"use strict";
var through2, livescript, Path, gutil, applySourceMap, VinylLSConverter;
through2 = require('through2');
livescript = require('livescript');
Path = require('path');
gutil = require('gulp-util');
applySourceMap = require('vinyl-sourcemaps-apply');
module.exports = function(options){
  return through2.obj(new VinylLSConverter(options || {}).transformFn);
};
/* jshint -W004 */
/* jshint -W014 */
/* jshint -W030 */
/* jshint -W033 */
/* jshint -W116 */
VinylLSConverter = (function(){
  VinylLSConverter.displayName = 'VinylLSConverter';
  var prototype = VinylLSConverter.prototype, constructor = VinylLSConverter;
  function VinylLSConverter(options){
    var ref$;
    this.options = options;
    this.transformFn = bind$(this, 'transformFn', prototype);
    this.isJson = (ref$ = options.json, delete options.json, ref$);
  }
  prototype.transformFn = function(file, enc, done){
    var ref$, error, clonedFile;
    ref$ = this._convert(file), error = ref$[0], clonedFile = ref$[1];
    if (error) {
      error = new gutil.PluginError("gulp-livescript", error);
    }
    done(error, clonedFile);
  };
  prototype._convert = function(file){
    if (file.isNull()) {
      return [null, file];
    } else if (file.isStream()) {
      return ["Streaming not supported", null];
    } else {
      return this._tryConvertToJS(file.clone());
    }
  };
  prototype._tryConvertToJS = function(clonedFile){
    var json, input, options, tokens, ast, clonedFilename, filename, output, result, error;
    try {
      json = this._convertFilepath(clonedFile);
      input = clonedFile.contents.toString("utf8");
      options = import$({}, this.options);
      options.bare || (options.bare = json);
      tokens = livescript.tokens(input, {
        raw: options.lex
      });
      ast = livescript.ast(tokens);
      if (json) {
        ast.makeReturn();
      }
      clonedFilename = Path.basename(clonedFile.path);
      filename = clonedFilename.replace(/js$/, 'ls');
      output = ast.compileRoot(options);
      if (json) {
        result = livescript.run(output.toString(), options, true);
        output = JSON.stringify(result, null, 2) + "\n";
        clonedFile.contents = new Buffer(output.toString());
      } else {
        output.setFile(filename);
        output = output.toStringWithSourceMap();
        if (clonedFile.sourceMap) {
          output.map._file = clonedFilename;
          applySourceMap(clonedFile, output.map.toString());
        }
        clonedFile.contents = new Buffer(output.code);
      }
    } catch (e$) {
      error = e$;
      error.message += "\nat " + clonedFile.path;
      clonedFile = null;
    }
    return [error, clonedFile];
  };
  prototype._convertFilepath = function(clonedFile){
    var dirname, filename, json, newFilename;
    dirname = Path.dirname(clonedFile.path);
    filename = Path.basename(clonedFile.path, ".ls");
    json = this.isJson || ".json" === Path.extname(filename);
    newFilename = json
      ? Path.basename(filename, ".json") + ".json"
      : filename + ".js";
    clonedFile.path = Path.join(dirname, newFilename);
    return json;
  };
  return VinylLSConverter;
}());
function bind$(obj, key, target){
  return function(){ return (target || obj)[key].apply(obj, arguments) };
}
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}
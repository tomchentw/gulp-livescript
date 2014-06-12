var through2, LiveScript, gutil, PluginError;
through2 = require('through2');
LiveScript = require('LiveScript');
gutil = require('gulp-util');
PluginError = gutil.PluginError;
module.exports = function(options){
  options || (options = {});
  function modifyLS(file, enc, done){
    var ref$, e, this$ = this;
    function emitError(it){
      this$.emit('error', new PluginError('gulp-livescript', it));
      done();
    }
    if (file.isNull()) {
      return done();
    }
    if (file.isStream()) {
      return emitError('Streaming not supported');
    }
    try {
      file.contents = new Buffer(LiveScript.compile(file.contents.toString('utf8'), (ref$ = {}, import$(ref$, options), ref$.filename = file.path, ref$)));
      file.path = gutil.replaceExtension(file.path, '.js');
    } catch (e$) {
      e = e$;
      return emitError(e);
    }
    this.push(file);
    done();
  }
  return through2.obj(modifyLS);
};
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}
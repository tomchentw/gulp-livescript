var through2, LiveScript, path, gutil;
through2 = require('through2');
LiveScript = require('LiveScript');
path = require('path');
gutil = require('gulp-util');
module.exports = function(options){
  options || (options = {});
  function modifyLS(file, enc, done){
    var error, input, dirname, filename, json, t;
    if (file.isNull()) {
      return done(null, file);
    }
    if (file.isStream()) {
      error = "Streaming not supported";
    } else {
      try {
        input = file.contents.toString("utf8");
        dirname = path.dirname(file.path);
        filename = path.basename(file.path, '.ls');
        if (path.extname(filename) === '.json' || options.json) {
          file.path = path.join(dirname, path.basename(file.path, '.json') + '.json');
          json = true;
        } else {
          file.path = path.join(dirname, filename + '.js');
          json = false;
        }
        t = {
          input: input,
          options: options
        };
        t.tokens = LiveScript.tokens(t.input, {
          raw: options.lex
        });
        t.ast = LiveScript.ast(t.tokens);
        options.bare || (options.bare = json);
        if (json) {
          t.ast.makeReturn();
        }
        t.output = t.ast.compileRoot(options);
        if (json) {
          t.result = LiveScript.run(t.output, options, true);
          t.output = JSON.stringify(t.result, null, 2) + '\n';
        }
        file.contents = new Buffer(t.output);
      } catch (e$) {
        error = e$;
      }
    }
    if (error) {
      error = new gutil.PluginError("gulp-livescript", error);
    }
    done(error, file);
  }
  return through2.obj(modifyLS);
};
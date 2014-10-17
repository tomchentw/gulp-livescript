var through2, LiveScript, gutil;
through2 = require('through2');
LiveScript = require('LiveScript');
gutil = require('gulp-util');
module.exports = function(options){
  options || (options = {});
  function modifyLS(file, enc, done){
    var error, fileExtension, input, t, json;
    if (file.isNull()) {
      return done(null, file);
    }
    if (file.isStream()) {
      error = "Streaming not supported";
    } else {
      try {
        fileExtension = ".js";
        input = file.contents.toString("utf8");
        t = {
          input: input,
          options: options
        };
        json = options.json;
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
          t.output = JSON.stringify(t.result, null, 2) + "\n";
          fileExtension = ".json";
        }
        file.contents = new Buffer(t.output);
        file.path = gutil.replaceExtension(file.path, fileExtension);
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
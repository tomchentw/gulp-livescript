var through2, LiveScript, gutil;
through2 = require('through2');
LiveScript = require('LiveScript');
gutil = require('gulp-util');
module.exports = function(options){
  options || (options = {});
  function modifyLS(file, enc, done){
    var error, ref$;
    if (file.isNull()) {
      return done(null, file);
    }
    if (file.isStream()) {
      error = 'Streaming not supported';
    } else {
      try {
        file.contents = new Buffer(LiveScript.compile(file.contents.toString('utf8'), (ref$ = {}, import$(ref$, options), ref$.filename = file.path, ref$)));
        file.path = gutil.replaceExtension(file.path, '.js');
      } catch (e$) {
        error = e$;
      }
    }
    if (error) {
      error = new gutil.PluginError('gulp-livescript', error);
    }
    done(error, file);
  }
  return through2.obj(modifyLS);
};
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}
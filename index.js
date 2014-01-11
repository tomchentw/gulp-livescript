var mapStream, LiveScript, gutil;
mapStream = require('map-stream');
LiveScript = require('LiveScript');
gutil = require('gulp-util');
module.exports = function(options){
  options || (options = {});
  function modifyLS(file, cb){
    var done, error, e;
    done = function(){
      cb(void 8, file);
    };
    error = function(it){
      cb(
      new gutil.PluginError('gulp-livescript', it));
    };
    if (file.isNull()) {
      return done();
    }
    if (file.isStream()) {
      return error('Streaming not supported');
    }
    try {
      file.contents = new Buffer(LiveScript.compile(file.contents.toString('utf8'), options));
      file.path = gutil.replaceExtension(file.path, '.js');
    } catch (e$) {
      e = e$;
      return error(e);
    }
    done();
  }
  return mapStream(modifyLS);
};
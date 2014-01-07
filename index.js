  var map = require('map-stream');
  var LiveScript = require('LiveScript');
  var gutil = require('gulp-util');

  module.exports = function(options){
    if (!options) options = {};

    function modifyLS(file, cb){
      if (file.isNull()) return cb(null, file);
      if (file.isStream()) return cb(toPluginError('gulp-livescript: Streaming not supported'));

      try {
        file.contents = new Buffer(LiveScript.compile(file.contents.toString('utf8'), options));
        file.path = gutil.replaceExtension(file.path, '.js');
      }
      catch (e) {
        return cb(new gutil.PluginError('gulp-livescript', e));
      }
      cb(null, file);
    }
    return map(modifyLS);
  };

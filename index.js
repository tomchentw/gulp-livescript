(function(){
  var Buffer, eventStream, LiveScript, gutil, toPluginError;
  Buffer = require('buffer').Buffer;
  eventStream = require('event-stream');
  LiveScript = require('LiveScript');
  gutil = require('gulp-util');
  toPluginError = function(reason){
    return new gutil.PluginError('gulp-livescript', reason);
  };
  module.exports = function(options){
    return eventStream.map(function(file, cb){
      var done, error;
      done = function(){
        cb(void 8, file);
      };
      if (file.isNull()) {
        done();
        return;
      }
      if (file.isStream()) {
        cb(
        toPluginError(
        'Streaming not supported'));
        return;
      }
      try {
        file.contents = new Buffer(LiveScript.compile(file.contents.toString('utf8'), options));
        file.path = gutil.replaceExtension(file.path, '.js');
      } catch (e$) {
        error = e$;
        return cb(
        toPluginError(
        error));
      }
      done();
    });
  };
}).call(this);

var through, LiveScript, gutil;
through = require('through2');
LiveScript = require('LiveScript');
gutil = require('gulp-util');
module.exports = function(options){
  options || (options = {});
  function modifyLS(file, enc, cb){
    var ref$, e;
    function fatalError(it){
      cb(
      new gutil.PluginError('gulp-livescript', it));
    }
    if (file.isNull()) {
      return cb();
    }
    if (file.isStream()) {
      return fatalError('Streaming not supported');
    }
    try {
      file.contents = new Buffer(LiveScript.compile(file.contents.toString('utf8'), (ref$ = {}, import$(ref$, options), ref$.filename = file.path, ref$)));
      file.path = gutil.replaceExtension(file.path, '.js');
    } catch (e$) {
      e = e$;
      return cb(new Error(e));
    }
    this.push(file);
    cb();
  }
  return through.obj(modifyLS);
};
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}
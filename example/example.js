/*
 * author: @stevelacy
 * url: https://github.com/stevelacy
 */
(function(){
  LiveScript.stab = function(code, callback, filename, error){
    var e;
    try {
      LiveScript.run(code, {
        filename: filename
      });
    } catch (e$) {
      e = e$;
      error;
    }
    return typeof callback === 'function' ? callback(error) : void 8;
  };
}).call(this);

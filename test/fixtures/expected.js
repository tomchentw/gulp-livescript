(function(){
  var curriedAdd, add5, slice$ = [].slice;
  function namedFunction(){
    var args, a, b, options;
    args = slice$.call(arguments);
    a = args.a, b = args.b, options = args.options;
    import$(options, a);
    return options.b = b, options;
  }
  curriedAdd = curry$(function(x, y, z){
    x + y + z;
  });
  add5 = curriedAdd(5);
  add5(6, 7);
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
  function curry$(f, bound){
    var context,
    _curry = function(args) {
      return f.length > 1 ? function(){
        var params = args ? args.concat() : [];
        context = bound ? context || this : this;
        return params.push.apply(params, arguments) <
            f.length && arguments.length ?
          _curry.call(context, params) : f.apply(context, params);
      } : f;
    };
    return _curry();
  }
}).call(this);

function namedFunction (...args)
  const {a, b, options} = args
  options <<< a
  options <<< {b}

const curriedAdd = !(x, y, z) -->
  x + y + z

const add5 = curriedAdd 5

add5 6, 7
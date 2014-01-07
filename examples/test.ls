LiveScript.stab = (code, callback, filename, error) ->
  try LiveScript.run code, {filename} catch then error
  callback? error
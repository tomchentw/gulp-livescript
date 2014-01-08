/*
 * author: @stevelacy
 * url: https://github.com/stevelacy
 */
LiveScript.stab = (code, callback, filename, error) ->
  try LiveScript.run code, {filename} catch then error
  callback? error
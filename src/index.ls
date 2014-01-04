require! {
  buffer.Buffer
  'event-stream'
  LiveScript
  gutil: 'gulp-util'
}

const toPluginError = (reason) ->
  new gutil.PluginError 'gulp-livescript', reason

module.exports = (options) -> event-stream.map !(file, cb) ->
  const done = !-> cb void, file
  if file.isNull!
    done!
    return
  if file.isStream!
    'Streaming not supported' |> toPluginError |> cb
    return

  try
    file.contents = file.contents.toString 'utf8' |> LiveScript.compile _, options |> new Buffer _
    file.path = gutil.replaceExtension file.path, '.js'
  catch error
    return error |> toPluginError |> cb
  done!
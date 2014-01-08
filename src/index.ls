require! {
  'map-stream'
  LiveScript
  gutil: 'gulp-util'
}

module.exports = (options || {}) -> 
  !function modifyLS (file, cb)
    const done = !-> cb void, file
    const error = !-> it |> new gutil.PluginError 'gulp-livescript', _ |> cb

    return done! if file.isNull!
    return error 'Streaming not supported' if file.isStream!

    try
      file.contents = file.contents.toString 'utf8' |> LiveScript.compile _, options |> new Buffer _
      file.path = gutil.replaceExtension file.path, '.js'
    catch e
      return error e
    done!

  map-stream modifyLS
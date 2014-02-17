require! {
  'map-stream'
  LiveScript
  gutil: 'gulp-util'
}



module.exports = (options || {}) -> 
  !function modifyLS (file, cb)
    !function done
      cb void, file

    !function fatalError
      it |> new gutil.PluginError 'gulp-livescript', _ |> cb

    return done! if file.isNull!
    return fatalError 'Streaming not supported' if file.isStream!

    try
      file.contents = file.contents.toString 'utf8' |> LiveScript.compile _, options |> new Buffer _
      file.path = gutil.replaceExtension file.path, '.js'
    catch e
      return cb new Error e
    done!

  map-stream modifyLS
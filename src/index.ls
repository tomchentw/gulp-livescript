require! {
  through: 'through2'
  LiveScript
  gutil: 'gulp-util'
}



module.exports = (options || {}) ->
  !function modifyLS (file, enc, cb)

    !function fatalError
      it |> new gutil.PluginError 'gulp-livescript', _ |> cb

    return cb! if file.isNull!
    return fatalError 'Streaming not supported' if file.isStream!

    try
      file.contents = file.contents.toString 'utf8' |>
        LiveScript.compile _, {...options, filename: file.path} |> new Buffer _
      file.path = gutil.replaceExtension file.path, '.js'
    catch e
      return cb new Error e
    @push file
    cb!

  through.obj modifyLS

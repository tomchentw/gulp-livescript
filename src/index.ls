require! {
  through2
  LiveScript
  gutil: 'gulp-util'
}

const {PluginError} = gutil

module.exports = (options || {}) ->
  !function modifyLS (file, enc, done)

    !~function emitError
      @emit 'error' new PluginError 'gulp-livescript', it
      done!

    return done! if file.isNull!
    return emitError 'Streaming not supported' if file.isStream!

    try
      file.contents = file.contents.toString 'utf8' |>
        LiveScript.compile _, {...options, filename: file.path} |> new Buffer _
      file.path = gutil.replaceExtension file.path, '.js'
    catch e
      return emitError e
    @push file
    done!

  through2.obj modifyLS

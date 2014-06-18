require! {
  through2
  LiveScript
  gutil: 'gulp-util'
}

module.exports = (options || {}) ->
  !function modifyLS (file, enc, done)
    return done null, file if file.isNull!

    if file.isStream!
      error = 'Streaming not supported'
    else
      try
        file.contents = file.contents.toString 'utf8' |>
          LiveScript.compile _, {...options, filename: file.path} |> new Buffer _
        file.path = gutil.replaceExtension file.path, '.js'
      catch error

    error = new gutil.PluginError 'gulp-livescript', error if error
    done error, file

  through2.obj modifyLS

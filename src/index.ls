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
        input = file.contents.toString 'utf8'
        t = {input, options}
        json = options.json
        t.tokens = LiveScript.tokens t.input, raw: options.lex
        t.ast = LiveScript.ast t.tokens
        options.bare ||= json
        t.ast.make-return! if json
        t.output = t.ast.compile-root options
        if json => 
          t.result = LiveScript.run t.output, options, true
          t.output = JSON.stringify(t.result, null, 2) + '\n'
        file.contents = new Buffer t.output
        file.path = gutil.replaceExtension file.path, '.js'
      catch error

    error = new gutil.PluginError 'gulp-livescript', error if error
    done error, file

  through2.obj modifyLS


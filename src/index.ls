require! {
  through2
  LiveScript
  path
  "gulp-util": gutil
}

module.exports = (options || {}) ->
  !function modifyLS (file, enc, done)
    return done null, file if file.isNull!

    if file.isStream!
      error = "Streaming not supported"
    else
      try
        input = file.contents.toString "utf8"
        
        dirname = path.dirname(file.path)
        filename = path.basename(file.path, '.ls')
        if path.extname(filename) == '.json' || options.json
          file.path = path.join do
             dirname,
             path.basename(file.path, '.json') + '.json'
          json = true
        else
          file.path = path.join(dirname, filename + '.js')
          json = false

        t = {input, options}
        t.tokens = LiveScript.tokens t.input, raw: options.lex
        t.ast = LiveScript.ast t.tokens

        options.bare ||= json

        t.ast.make-return! if json
        t.output = t.ast.compile-root options

        if json
          t.result = LiveScript.run t.output, options, true
          t.output = JSON.stringify(t.result, null, 2) + '\n'

        file.contents = new Buffer t.output

      catch error

    error = new gutil.PluginError "gulp-livescript", error if error
    done error, file

  through2.obj modifyLS

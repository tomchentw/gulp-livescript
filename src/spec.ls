require! {
  fs
  path.join
  'gulp-livescript': './index'
  gutil: 'gulp-util'
  mocha
  should
}

(...) <-! describe 'gulp-livescript'

it 'should compile ls into js' !(done) ->
  expectEquals = !(left, right) -->
    String(left.contents) .should.equal String(right.contents)
    done!

  const stream = gulp-livescript header: true
  stream.on 'error' done
  stream.on 'data' !(compiled) ->
    should.exist compiled
    should.exist compiled.path
    should.exist compiled.relative
    should.exist compiled.contents

    compiled.relative.should.equal 'test.js'
    expectEquals := expectEquals compiled
  #
  fs.readFile join(__dirname, '../misc/test.ls'), !(err, contents) ->
    stream.write new gutil.File do
      base: join __dirname, '../misc/'
      cwd: __dirname
      path: join __dirname, '../misc/test.ls'
      contents: contents

  fs.readFile join(__dirname, '../misc/test.js'), !(err, contents) ->
    expectEquals := expectEquals new gutil.File do
      base: join __dirname, '../misc/'
      cwd: __dirname
      path: join __dirname, '../misc/test.js'
      contents: contents


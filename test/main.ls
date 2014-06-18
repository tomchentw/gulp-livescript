require! {
  fs
  gutil: 'gulp-util'
  should
  mocha
}

const gulp-livescript = require if process.env.TRAVIS then '../' else '../src'

(...) <-! describe 'gulp-livescript'

it 'should compile livescript file to javascript' !(done) ->
  const ls = gulp-livescript!
  const fakeFile = new gutil.File do
      base: 'test/fixtures'
      cwd: 'test/fixtures'
      path: 'test/fixtures/file.ls'
      contents: fs.readFileSync 'test/fixtures/file.ls'

  ls.once 'data' !(expectedFile) ->
    should.exist expectedFile
    should.exist expectedFile.path
    should.exist expectedFile.contents 
    String expectedFile.contents .should.equal fs.readFileSync('test/fixtures/expected.js', 'utf8')
    done!

  ls.write fakeFile

it 'should compile livescript with bare option to javascript' !(done) ->
  const ls = gulp-livescript bare: true
  const fakeFile = new gutil.File do
      base: 'test/fixtures'
      cwd: 'test/fixtures'
      path: 'test/fixtures/file.ls'
      contents: fs.readFileSync 'test/fixtures/file.ls'

  ls.once 'data' !(expectedFile) ->
    should.exist expectedFile
    should.exist expectedFile.path
    should.exist expectedFile.contents 
    String expectedFile.contents .should.equal fs.readFileSync('test/fixtures/bare-expected.js', 'utf8')
    done!

  ls.write fakeFile

it 'should emit error when livescript compilation fails' !(done) ->
  const ls = gulp-livescript bare: true
  const fakeFile = new gutil.File do
      base: 'test/fixtures'
      cwd: 'test/fixtures'
      path: 'test/fixtures/illegal.ls'
      contents: fs.readFileSync 'test/fixtures/illegal.ls'

  ls.once 'error' !(error) ->
    should.exist error
    should.exist error.message
    error.message.should.equal "Parse error on line 1: Unexpected 'ID'\nat test/fixtures/illegal.ls"
    done!

  ls.write fakeFile

it 'should emit error with streaming files' !(done) ->
  const ls = gulp-livescript bare: true
  const fakeFile = new gutil.File do
      base: 'test/fixtures'
      cwd: 'test/fixtures'
      path: 'test/fixtures/illegal.ls'
      contents: fs.createReadStream 'test/fixtures/file.ls'

  ls.once 'error' !(error) ->
    should.exist error
    should.exist error.message
    error.message.should.equal "Streaming not supported"
    done!

  ls.write fakeFile

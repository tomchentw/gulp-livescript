require! {
  fs
  gutil: 'gulp-util'
  'gulp-livescript': '../src'
  should
  mocha
}

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

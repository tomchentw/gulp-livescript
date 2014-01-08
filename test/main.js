(function(){
  var fs, gutil, gulpLivescript, should, mocha;
  fs = require('fs');
  gutil = require('gulp-util');
  gulpLivescript = require('../index');
  should = require('should');
  mocha = require('mocha');
  describe('gulp-livescript', function(){
    it('should compile livescript file to javascript', function(done){
      var ls, fakeFile;
      ls = gulpLivescript();
      fakeFile = new gutil.File({
        base: 'test/fixtures',
        cwd: 'test/fixtures',
        path: 'test/fixtures/file.ls',
        contents: fs.readFileSync('test/fixtures/file.ls')
      });
      ls.once('data', function(expectedFile){
        should.exist(expectedFile);
        should.exist(expectedFile.path);
        should.exist(expectedFile.contents);
        String(expectedFile.contents).should.equal(fs.readFileSync('test/fixtures/expected.js', 'utf8'));
        done();
      });
      ls.write(fakeFile);
    });
  });
}).call(this);

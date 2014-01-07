var fs = require('fs');
var gutil = require('gulp-util');
var should = require('should');
var lscript = require('../');
require('mocha');

describe('gulp-livescript', function(){

  it('should compile livescript files to javascript', function(done){
    var ls = lscript();
    var fakeFile = new gutil.File({
      base: 'test/fixtures',
      cwd: 'test/fixtures',
      path: 'test/fixtures/file.ls',
      contents: fs.readFileSync('test/fixtures/file.ls')
    });
    
    ls.once('data', function(newFile){
      should.exist(newFile);
      should.exist(newFile.path);
      should.exist(newFile.contents);
      String(newFile.contents).should.equal(fs.readFileSync('test/fixtures/expected.js', 'utf8'));
      done();
    });
    ls.write(fakeFile);
  });

});
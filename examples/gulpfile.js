var gulp = require('gulp');
var liveScript = require('../');


gulp.task('ls', function(){
  gulp.src('./test.ls')
  .pipe(liveScript())
  .pipe(gulp.dest('./'));
});
  
gulp.task('default', function(){
  gulp.run('ls');
});
var gulp = require('gulp');
var gulpLiveScript = require('../');


gulp.task('ls', function(){
  gulp.src('./example.ls')
  .pipe(gulpLiveScript())
  .pipe(gulp.dest('./'));
});
  
gulp.task('default', function(){
  gulp.run('ls');
});
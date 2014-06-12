require! {
  fs
  gulp
  'gulp-livescript': './src'
  'gulp-bump'
  'conventional-changelog'
}
/*
 *
 * Define public interfaces for Makefile
 *
 */
gulp.task 'release' <[ build bump ]> !(done) ->
  !function changeParsed (err, log)
    return done err if err
    fs.writeFile 'CHANGELOG.md', log, done

  (err, data) <-! fs.readFile './package.json', 'utf8'
  const {repository, version} = JSON.parse data
  conventional-changelog {
    repository: repository.url
    version: version
  }, changeParsed
/*
 *
 * Private support tasks, don't directly run them through cli
 *
 */
gulp.task 'build' ->
  gulp.src 'src/index.ls'
  .pipe gulp-livescript bare: true
  .pipe gulp.dest '.'

gulp.task 'bump' ->
  gulp.src 'package.json'
  .pipe gulp-bump type: process.env.TYPE || 'patch'
  .pipe gulp.dest '.'

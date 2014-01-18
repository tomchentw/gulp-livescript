require! {
  gulp
  'gulp-livescript': './src'
  'gulp-bump'
  'gulp-conventional-changelog'
  'gulp-exec'
  'event-stream'
}

gulp.task 'build' ->
  const index = do
    gulp.src 'src/index.ls'
    .pipe gulp-livescript bare: true
    .pipe gulp.dest '.'

  const main = do
    gulp.src 'src/main.ls'
    .pipe gulp-livescript!
    .pipe gulp.dest 'test/'

  return event-stream.merge index, main

gulp.task 'bump' ->
  return gulp.src 'package.json'
    .pipe gulp-bump type: 'patch'
    .pipe gulp.dest '.'

gulp.task 'release' <[ build bump ]> ->
  const jsonFile = require './package.json'
  const commitMsg = "chore(release): #{ jsonFile.version }"

  return gulp.src <[ package.json CHANGELOG.md ]>
    .pipe gulp-conventional-changelog!
    .pipe gulp.dest '.'
    .pipe gulp-exec('git add -A')
    .pipe gulp-exec("git commit -m '#{ commitMsg }'")
    .pipe gulp-exec("git tag -a #{ jsonFile.version } -m '#{ commitMsg }'")
    .pipe gulp-exec('git push')
    .pipe gulp-exec('git push --tags')
    .pipe gulp-exec('npm publish')

require! {
  gulp
  'gulp-livescript': './src'
  'gulp-bump'
  'gulp-conventional-changelog'
  'gulp-release'
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

gulp.task 'release' <[build]> ->
  const bumpStream = do
    gulp.src 'package.json'
      .pipe gulp-bump bump: 'patch'
      .pipe gulp.dest '.'

  const cgLogStream = do
    event-stream.merge bumpStream, gulp.src 'CHANGELOG.md'
      .pipe gulp-conventional-changelog!
      .pipe gulp.dest '.'

  const releaseStream = gulp-release do
    commit: do
      message: 'chore(release): <%= package.version %>'
      
  packFile = void
  return event-stream.merge bumpStream, cgLogStream
    .pipe event-stream.through !(data) ->
      if packFile
        @pipe releaseStream
        @emit 'data' packFile
      else
        # first come must be package.json
        packFile := data 




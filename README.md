# gulp-livescript
> Compile LiveScript to JavaScript for Gulp

[![Version][npm-image]][npm-url] [![Travis CI][travis-image]][travis-url] [![Quality][codeclimate-image]][codeclimate-url] [![Coverage][codeclimate-coverage-image]][codeclimate-coverage-url] [![Dependencies][gemnasium-image]][gemnasium-url] [![Gitter][gitter-image]][gitter-url]


## Installation

```sh
npm i --save gulp-livescript
```


## Information

<table>
<tr>
<td>Package</td><td>gulp-livescript</td>
</tr>
<tr>
<td>Description</td>
<td>Compile LiveScript to JavaScript for Gulp</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.10</td>
</tr>
<tr>
<td>Gulp Version</td>
<td>>= 3.5.0</td>
</tr>
</table>


## Example

### See how we compile [`src/index.ls`](https://github.com/tomchentw/gulp-livescript/blob/master/src/index.ls) to [`lib/index.js`](https://github.com/tomchentw/gulp-livescript/blob/master/lib/index.js) in [this project](https://github.com/tomchentw/gulp-livescript/blob/631b6f34e74133a595609732d724e98649ab48a6/gulpfile.ls).

*Notice:* I used gulpfile to compile src to lib in the old days, now I use `lsc` compiler directly.

![`gulpfile.ls`](https://f.cloud.github.com/assets/922234/2353915/093164d2-a5ae-11e3-8016-d1191004acb2.png)


## Usage

```javascript
var gulpLiveScript = require('gulp-livescript');
var log = require('fancy-log');

gulp.task('ls', function() {
  return gulp.src('./src/*.ls')
    .pipe(gulpLiveScript({bare: true})
    .on('error', log.error))
    .pipe(gulp.dest('./public/'));
});
```


### Error Handling

`gulp-livescript` will [emit an error](https://github.com/tomchentw/gulp-livescript/blob/master/test/main.ls#L45) for cases such as invalid LiveScript syntax.

If you need to exit gulp with non-0 exit code, attatch a lister and throw the error:

```livescript
gulp.task 'build' ->
  return gulp.src 'test/fixtures/illegal.ls'
    .pipe gulp-livescript bare: true
    .on 'error' -> throw it
    .pipe gulp.dest '.'
```


### Options

The options object supports the same options as the standard LiveScript compiler.

## Source maps

gulp-livescript can be used in tandem with [gulp-sourcemaps](https://github.com/floridoo/gulp-sourcemaps) to generate source maps for the livescript to javascript transition. You will need to initialize [gulp-sourcemaps](https://github.com/floridoo/gulp-sourcemaps) prior to running the gulp-livescript compiler and write the source maps after.

```javascript
var sourcemaps = require('gulp-sourcemaps');

gulp.src('./src/*.ls')
  .pipe(sourcemaps.init())
  .pipe(livescript())
  .pipe(sourcemaps.write())
  .pipe(gulp.dest('./dest/js'));

// will write the source maps inline in the compiled javascript files
```

By default, [gulp-sourcemaps](https://github.com/floridoo/gulp-sourcemaps) writes the source maps inline in the compiled javascript files. To write them to a separate file, specify a relative file path in the `sourcemaps.write()` function.

```javascript
var sourcemaps = require('gulp-sourcemaps');

gulp.src('./src/*.ls')
  .pipe(sourcemaps.init())
  .pipe(livescript({ bare: true })).on('error', gutil.log)
  .pipe(sourcemaps.write('./maps'))
  .pipe(gulp.dest('./dest/js'));

// will write the source maps to ./dest/js/maps
```

## Contributing

[![devDependency Status][david-dm-image]][david-dm-url]

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Credits

* [`gulp-coffee` by @wearefractal](https://github.com/wearefractal/gulp-coffee)


[npm-image]: https://img.shields.io/npm/v/gulp-livescript.svg?style=flat-square
[npm-url]: https://www.npmjs.org/package/gulp-livescript

[travis-image]: https://img.shields.io/travis/tomchentw/gulp-livescript.svg?style=flat-square
[travis-url]: https://travis-ci.org/tomchentw/gulp-livescript
[codeclimate-image]: https://img.shields.io/codeclimate/github/tomchentw/gulp-livescript.svg?style=flat-square
[codeclimate-url]: https://codeclimate.com/github/tomchentw/gulp-livescript
[codeclimate-coverage-image]: https://img.shields.io/codeclimate/coverage/github/tomchentw/gulp-livescript.svg?style=flat-square
[codeclimate-coverage-url]: https://codeclimate.com/github/tomchentw/gulp-livescript
[gemnasium-image]: https://img.shields.io/gemnasium/tomchentw/gulp-livescript.svg?style=flat-square
[gemnasium-url]: https://gemnasium.com/tomchentw/gulp-livescript
[gitter-image]: https://badges.gitter.im/Join%20Chat.svg
[gitter-url]: https://gitter.im/tomchentw/gulp-livescript?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge
[david-dm-image]: https://img.shields.io/david/dev/tomchentw/gulp-livescript.svg?style=flat-square
[david-dm-url]: https://david-dm.org/tomchentw/gulp-livescript#info=devDependencies

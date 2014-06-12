# gulp-livescript [![Travis CI][travis-image]][travis-url] [![Quality][codeclimate-image]][codeclimate-url] [![Coverage][coveralls-image]][coveralls-url] [![Dependencies][gemnasium-image]][gemnasium-url]
> Compile LiveScript to JavaScript for Gulp

[![Version][npm-image]][npm-url]


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

### See how we compile [`src/index.ls`](https://github.com/tomchentw/gulp-livescript/blob/master/src/index.ls) to [`index.js`](https://github.com/tomchentw/gulp-livescript/blob/master/index.js) in [this project](https://github.com/tomchentw/gulp-livescript/blob/master/gulpfile.ls).

![`gulpfile.ls`](https://f.cloud.github.com/assets/922234/2353915/093164d2-a5ae-11e3-8016-d1191004acb2.png)


## Usage

```javascript
var gulpLiveScript = require('gulp-livescript');

gulp.task('ls', function() {
  return gulp.src('./src/*.ls')
    .pipe(gulpLiveScript({bare: true})
    .on('error', gutil.log))
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


## Contributing

[![devDependency Status][david-dm-image]][david-dm-url]

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Credits

* [`gulp-coffee` by @wearefractal](https://github.com/wearefractal/gulp-coffee)


[npm-image]: https://img.shields.io/npm/v/gulp-livescript.svg
[npm-url]: https://www.npmjs.org/package/gulp-livescript

[travis-image]: https://travis-ci.org/tomchentw/gulp-livescript.svg?branch=master
[travis-url]: https://travis-ci.org/tomchentw/gulp-livescript
[codeclimate-image]: https://img.shields.io/codeclimate/github/tomchentw/gulp-livescript.svg
[codeclimate-url]: https://codeclimate.com/github/tomchentw/gulp-livescript
[coveralls-image]: https://img.shields.io/coveralls/tomchentw/gulp-livescript.svg
[coveralls-url]: https://coveralls.io/r/tomchentw/gulp-livescript
[gemnasium-image]: https://gemnasium.com/tomchentw/gulp-livescript.svg
[gemnasium-url]: https://gemnasium.com/tomchentw/gulp-livescript
[david-dm-image]: https://david-dm.org/tomchentw/gulp-livescript/dev-status.svg?theme=shields.io
[david-dm-url]: https://david-dm.org/tomchentw/gulp-livescript#info=devDependencies

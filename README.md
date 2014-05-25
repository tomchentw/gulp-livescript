# gulp-livescript
> Distributed via

[![Version     ](https://img.shields.io/npm/v/gulp-livescript.svg)                             ](https://www.npmjs.org/package/gulp-livescript)

> Compile LiveScript to JavaScript for Gulp

[![Travis CI   ](https://img.shields.io/travis/tomchentw/gulp-livescript/master.svg)           ](https://travis-ci.org/tomchentw/gulp-livescript)
[![Quality     ](https://img.shields.io/codeclimate/github/tomchentw/gulp-livescript.svg)      ](https://codeclimate.com/github/tomchentw/gulp-livescript)
[![Dependencies](https://img.shields.io/gemnasium/tomchentw/gulp-livescript.svg)               ](https://gemnasium.com/tomchentw/gulp-livescript)


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

[![devDependency Status](https://david-dm.org/tomchentw/gulp-livescript/dev-status.svg?theme=shields.io)](https://david-dm.org/tomchentw/gulp-livescript#info=devDependencies)

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Credits

* [`gulp-coffee` by @wearefractal](https://github.com/wearefractal/gulp-coffee)

var gulp = require('gulp');
var sass = require('gulp-sass');
var imageResize = require('gulp-image-resize');

function handleError (err) {
  console.log(err);
  this.emit('end');
}

gulp.task('sass', function () {
  return gulp.src('scss/app.scss')
    .pipe(sass())
    .on('error', handleError)
    .pipe(gulp.dest('static/css'))
});

gulp.task('fonts', function () {
  gulp.src('node_modules/font-awesome/fonts/*').pipe(gulp.dest('static/fonts'));
})

gulp.task('img', function () {
  var img = gulp.src('img/*');

  img.pipe(imageResize({
    width: 400,
    imageMagick: true,
  })).pipe(gulp.dest('static/img/thumbs'));

  img.pipe(imageResize({
    width: 1024,
    imageMagick: true,
  })).pipe(gulp.dest('static/img'));
})

gulp.task('watch', function () {
  gulp.watch('scss/*.scss', ['sass']);
  gulp.watch('img/*', ['img']);
  gulp.watch('fonts/*', ['fonts']);
});

gulp.task('develop', ['watch', 'sass', 'img', 'fonts']);
gulp.task('build', ['sass', 'img', 'fonts']);
gulp.task('default', ['develop']);

var gulp = require('gulp');

gulp.task('Setup', function () {
    return gulp.src('jspm_packages/**/*').pipe(gulp.dest('wwwroot/jspm_packages'));
});
import gulp from 'gulp'
import del from 'del'
import ava from 'gulp-ava'
import babel from 'gulp-babel'
import coffee from 'gulp-coffee'
import coffeelint from 'gulp-coffeelint'

const options = {
  paths: {
    src: ['src/**/*.coffee'],
    test: ['test/**/*-test.js'],
    maps: 'maps',
    target: 'lib',
  },
  coffee: {
    bare: true,
  },
  babel: {
    plugins: ['transform-es2015-modules-commonjs'],
  },
  ava: {
    nyc: true,
  },
}

gulp.task('default', ['build'])

gulp.task('lint', () =>
  gulp.src(options.paths.src).
    pipe(coffeelint()).
    pipe(coffeelint.reporter())
)

gulp.task('test', ['build'], () =>
  gulp.src(options.paths.test).
    pipe(ava(options.ava))
)

gulp.task('build', ['clean', 'lint'], () =>
  gulp.src(options.paths.src).
    pipe(coffee(options.coffee)).
    pipe(babel(options.babel)).
    pipe(gulp.dest(options.paths.target))
)

gulp.task('clean', () =>
  del([options.paths.target, 'coverage', '.nyc_output'])
)

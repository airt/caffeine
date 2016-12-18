
gulp = require 'gulp'
del = require 'del'
ava = require 'gulp-ava'
babel = require 'gulp-babel'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'

options =
  paths:
    src: ['src/**/*.coffee']
    test: ['test/**/*-test.js']
    target: 'lib'
  coffee:
    bare: true
  babel:
    plugins: ['transform-es2015-modules-commonjs']
  ava:
    nyc: true

gulp.task 'default', ['build']

gulp.task 'lint', ->
  gulp.src(options.paths.src).
    pipe(coffeelint()).
    pipe(coffeelint.reporter())

gulp.task 'test', ['build'], ->
  gulp.src(options.paths.test).
    pipe(ava(options.ava))

gulp.task 'build', ['clean'], ->
  gulp.src(options.paths.src).
    pipe(coffee(options.coffee)).
    pipe(babel(options.babel)).
    pipe(gulp.dest(options.paths.target))

gulp.task 'clean', ->
  del([options.paths.target, 'coverage', '.nyc_output'])

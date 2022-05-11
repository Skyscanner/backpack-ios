const path = require('path');
const data = require('gulp-data');
const gulp = require('gulp');
const nunjucks = require('gulp-nunjucks');
const rename = require('gulp-rename');
const { iconsSwiftUI } = require('../../iconNames');

const generateIconNamesSwiftUI = (templateFolder) => (done) => {
  gulp
    .src(path.join(templateFolder, 'BPKIcons.njk'))
    .pipe(data(iconsSwiftUI()))
    .pipe(nunjucks.compile())
    .pipe(rename('BPKIcons.swift'))
    .pipe(gulp.dest('Backpack-SwiftUI/Icons/Classes/Generated'))
  done()
};

module.exports = generateIconNamesSwiftUI
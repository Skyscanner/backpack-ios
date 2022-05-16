/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

const path = require('path');
const data = require('gulp-data');
const gulp = require('gulp');
const nunjucks = require('gulp-nunjucks');
const rename = require('gulp-rename');

const generateAutoMirrorIconNames = (templateFolder) => (done) => {
    const content = require('@skyscanner/bpk-svgs/dist/metadata.json');
    const iconNames = Object.entries(content).filter((x) => x[1].autoMirror).map(item => item[0]);

    gulp
      .src(path.join(templateFolder, 'BPKAutoMirrorIconNames.njk'))
      .pipe(data({iconNames: iconNames}))
      .pipe(nunjucks.compile())
      .pipe(rename('BPKAutoMirrorIconNames.swift'))
      .pipe(gulp.dest('Backpack-Common'))
    done()
}

module.exports = generateAutoMirrorIconNames
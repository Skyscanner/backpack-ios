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
const rename = require('gulp-rename');

// Lazy-load the ESM-only gulp-nunjucks from CJS
const getNunjucksCompile = async () =>
  (await import('gulp-nunjucks')).nunjucksCompile;

const generateAutoMirrorIconNames = (templateFolder) => async () => {
  const { default: content } = await import('@skyscanner/bpk-svgs/dist/metadata.json', {
    assert: { type: 'json' }
  }).catch(() => ({ default: require('@skyscanner/bpk-svgs/dist/metadata.json') })); // fallback for Node <20

  const iconNames = Object.entries(content)
    .filter(([, v]) => v.autoMirror)
    .map(([k]) => k);

  const nunjucksCompile = await getNunjucksCompile();

  // Return the stream (no manual done())
  return gulp
    .src(path.join(templateFolder, 'BPKAutoMirrorIconNames.njk'))
    .pipe(data({ iconNames }))
    .pipe(nunjucksCompile())
    .pipe(rename('BPKAutoMirrorIconNames.swift'))
    .pipe(gulp.dest('Backpack-Common/Icons/Generated'));
};

module.exports = generateAutoMirrorIconNames;
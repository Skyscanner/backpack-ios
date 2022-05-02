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

const gulp = require('gulp');
const nunjucks = require('gulp-nunjucks');
const data = require('gulp-data');
const rename = require('gulp-rename');
const merge2 = require('merge2');
const del = require('del');
const _ = require('lodash');
const tokens = require('@skyscanner/bpk-foundations-ios/tokens/base.ios.json');
const fonts = require('./scripts/gulp/fonts');
const iconNames = require('./scripts/gulp/iconNames');
const borderWidths = require('./scripts/gulp/borderWidths');
const radii = require('./scripts/gulp/radii');
const shadows = require('./scripts/gulp/shadows');
const colors = require('./scripts/gulp/colours');
const durations = require('./scripts/gulp/durations');
const spacings = require('./scripts/gulp/spacings');
const dynamicColors = require('./scripts/gulp/dynamicColours');
const getLegibleName = require('./scripts/gulp/utils/legibleName');
const { formatPrefixedConstName, parseColor, isDynamicColor, capitaliseFirstLetter } = require('./scripts/gulp/utils/formatUtils');
const objectiveC = require('./scripts/gulp/generation/objc');

const PATHS = {
  templates: path.join(__dirname, 'templates'),
  output: path.join(__dirname, 'Backpack'),
};

const parseTokens = (tokensData) => {
  const properties = tokensData.properties
  return _.chain([
    ...dynamicColors(properties, isDynamicColor),
    ...colors(properties, isDynamicColor, parseColor),
    ...fonts(properties),
    ...spacings(properties, formatPrefixedConstName, getLegibleName),
    ...radii(properties, formatPrefixedConstName, getLegibleName),
    ...borderWidths(properties, formatPrefixedConstName, getLegibleName),
    ...shadows(properties, parseColor, getLegibleName),
    ...durations(properties),
  ])
    .groupBy(({ type }) => type)
    .value();
};

const generateTemplates = (templateData) => () => {
  const generate = (template, destination) => gulp
    .src(path.join(PATHS.templates, template))
    .pipe(data(() => templateData))
    .pipe(nunjucks.compile())
    .pipe(destination)

  const streams = objectiveC(generate);
  return merge2(streams).pipe(gulp.dest(PATHS.output));
}

const copyIconFont = (done) => {
  merge2([
    gulp.src('node_modules/@skyscanner/bpk-svgs/dist/font/BpkIconIOS.ttf').pipe(
      rename({
        basename: 'BpkIconIOS',
      }),
    ),
    gulp.src('node_modules/@skyscanner/bpk-svgs/dist/font/iconMapping.json'),
  ]).pipe(gulp.dest(path.join(PATHS.output, 'Icon', 'Assets')));
  done();
}

const generateIconNames = (done) => {
  gulp
    .src(
      path.join(
        PATHS.templates,
        `{BPKIconNames.h.njk,BPKIconNames.m.njk,BPKSmallIconNames.h.njk,BPKSmallIconNames.m.njk,BPKLargeIconNames.h.njk,BPKLargeIconNames.m.njk,BPKXlIconNames.h.njk,BPKXlIconNames.m.njk}`
      )
    )
    .pipe(data(iconNames(capitaliseFirstLetter)))
    .pipe(nunjucks.compile())
    .pipe(
      rename((file) => {
        // eslint-disable-next-line no-param-reassign
        file.extname = '';
      })
    )
    .pipe(gulp.dest(path.join(PATHS.output, 'Icon', 'Classes', 'Generated')));
  done();
};

gulp.task('generate-icon-names', generateIconNames);
gulp.task('template', gulp.series('generate-icon-names', generateTemplates(parseTokens(tokens))));
gulp.task('copy-icon-font', copyIconFont);
gulp.task('default', gulp.series('template', 'copy-icon-font'));
gulp.task('clean', () => del([PATHS.output], { force: true }));

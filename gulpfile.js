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
const gulp = require('gulp')
const nunjucks = require('gulp-nunjucks');
const data = require('gulp-data');
const rename = require('gulp-rename');
const merge2 = require('merge2');
const del = require('del');
const path = require('path');
const _ = require('lodash');
const tinycolor = require('tinycolor2');
const tokens = require('bpk-tokens/tokens/base.ios.json');

const PATHS = {
  templates: path.join(__dirname, 'templates'),
  output: path.join(__dirname, 'Backpack', 'Classes', 'Generated'),
};

const TYPES = new Set(['color']);

const format = (s) => s[0].toUpperCase() + _.camelCase(s.substring(1));

const parseColor = (color) => {
  const parsedColor = tinycolor(color);

  const { r, g, b, a } = parsedColor.toRgb();

  return {
    r: (r / 255.0).toFixed(3),
    g: (g / 255.0).toFixed(3),
    b: (b / 255.0).toFixed(3),
    a,
  };
};

const parseTokens = (tokensData) => (
  _
    .chain(tokensData.properties)
    .filter(({ type }) => TYPES.has(type))
    .map(({ name, value, type }) => ({ name, type, value: type === 'color' ? parseColor(value) : value }))
    .groupBy(({ type }) => type)
    .value()
);


gulp.task('template', () => {
  let streams = [];
  const templateData = parseTokens(tokens);

  for (let type of TYPES) {
    const processedType = format(type);

    streams.push(
      gulp.src(path.join(PATHS.templates, `BPK${processedType}s.h.njk`))
      .pipe(data(() => templateData))
      .pipe(nunjucks.compile())
      .pipe(rename(`BPK${processedType}.h`))
    );

    streams.push(
      gulp.src(path.join(PATHS.templates, `BPK${processedType}s.m.njk`))
      .pipe(data(() => templateData))
      .pipe(nunjucks.compile())
      .pipe(rename(`BPK${processedType}.m`))
    );
  }

  return merge2(streams).pipe(gulp.dest(PATHS.output))
});

gulp.task('default', ['template']);
gulp.task('clean', () => del([PATHS.output], { force: true }));

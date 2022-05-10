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
const { fontTokens } = require('./scripts/gulp/fonts');
const { iconsUIKit, iconsSwiftUI } = require('./scripts/gulp/iconNames');
const borderWidths = require('./scripts/gulp/borderWidths');
const { radiiTokens } = require('./scripts/gulp/radii');
const shadows = require('./scripts/gulp/shadows');
const colors = require('./scripts/gulp/colours');
const durations = require('./scripts/gulp/durations');
const { spacingTokens } = require('./scripts/gulp/spacings');
const dynamicColors = require('./scripts/gulp/dynamicColours');
const getLegibleName = require('./scripts/gulp/utils/legibleName');
const { formatPrefixedConstName, parseColor, capitaliseFirstLetter, lowercaseFirstLetter } = require('./scripts/gulp/utils/formatUtils');
const objectiveC = require('./scripts/gulp/generation/objc');
const swiftUI = require('./scripts/gulp/generation/swiftui');
const generateSvgIcons = require('./scripts/gulp/generation/iconSvgs');

const PATHS = {
  templates: {
    objc: path.join(__dirname, 'templates'),
    swiftui: path.join(__dirname, 'templates/swiftui')
  },
  output: path.join(__dirname, 'Backpack'),
};

const parseSwiftUITokens = (tokensData) => {
  const properties = tokensData.properties

  return _.chain([
    ...radiiTokens.swiftui(properties),
    ...spacingTokens.swiftui(properties),
    ...dynamicColors(properties),
    ...fontTokens.swiftui(properties),
    ...colors(properties, e => !e.name.toLowerCase().endsWith('darkcolor') && !e.name.toLowerCase().endsWith('lightcolor')),
  ])
    .groupBy(({ type }) => type)
    .value();
};

const parseUIKitTokens = (tokensData) => {
  const properties = tokensData.properties
  return _.chain([
    ...dynamicColors(properties),
    ...colors(properties),
    ...fontTokens.uikit(properties),
    ...spacingTokens.uikit(properties),
    ...radiiTokens.uikit(properties),
    ...borderWidths(properties, formatPrefixedConstName, getLegibleName),
    ...shadows(properties, parseColor, getLegibleName),
    ...durations(properties),
  ])
    .groupBy(({ type }) => type)
    .value();
};

const generateFromTemplate = (templatesFolder, templateData) =>
  (template, destination) => gulp
    .src(path.join(templatesFolder, template))
    .pipe(data(() => templateData))
    .pipe(nunjucks.compile())
    .pipe(destination)

const generateSwiftUI = (templateData) => () => {
  const streams = swiftUI(generateFromTemplate(PATHS.templates.swiftui, templateData))
  return merge2(streams).pipe(gulp.dest('Backpack-SwiftUI'))
}

const generateUIKit = (templateData) => () => {
  const streams = objectiveC(generateFromTemplate(PATHS.templates.objc, templateData))
  return merge2(streams).pipe(gulp.dest(PATHS.output));
}
const generateIconNamesUIKit = (done) => {
  gulp
    .src(
      path.join(
        PATHS.templates.objc,
        `{BPKIconNames.h.njk,BPKIcons.swift.njk,BPKIconNames.m.njk,BPKSmallIconNames.h.njk,BPKSmallIconNames.m.njk,BPKLargeIconNames.h.njk,BPKLargeIconNames.m.njk,BPKXlIconNames.h.njk,BPKXlIconNames.m.njk}`
      )
    )
    .pipe(data(iconsUIKit()))
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

// Create helper for icons example screen
const generateIconExampleUtil = (done) => {
  const mappings = require('@skyscanner/bpk-svgs/dist/font/iconMapping.json')

  gulp
    .src(path.join(PATHS.templates.swiftui, 'icons/BPKIconsExampleUtil.njk'))
    .pipe(data({ icons: Object.keys(mappings) }))
    .pipe(nunjucks.compile())
    .pipe(rename('BPKIconsExampleUtil.swift'))
    .pipe(gulp.dest('Example/Backpack/ViewControllers/Icons/Generated'))
  done()
};

// Create helper for icons tests
const generateIconExampleTestsUtil = (done) => {
  const mappings = require('@skyscanner/bpk-svgs/dist/font/iconMapping.json')

  gulp
    .src(path.join(PATHS.templates.swiftui, 'icons/BPKIconsExampleTestsUtil.njk'))
    .pipe(data({ icons: Object.keys(mappings) }))
    .pipe(nunjucks.compile())
    .pipe(rename('BPKIconsTestsUtils.m'))
    .pipe(gulp.dest('Example/SnapshotTests/Utils/'))
  done()
};

const generateIconNamesSwiftUI = (done) => {
  gulp
    .src(path.join(PATHS.templates.swiftui, 'icons/BPKIcons.njk'))
    .pipe(data(iconsSwiftUI()))
    .pipe(nunjucks.compile())
    .pipe(rename('BPKIcons.swift'))
    .pipe(gulp.dest('Backpack-SwiftUI/Icons/Classes/Generated'))
  done()
};

gulp.task('generate-icon-names', gulp.series(
  generateIconNamesSwiftUI,
  generateIconNamesUIKit,
  generateIconExampleUtil,
  generateIconExampleTestsUtil,
  generateSvgIcons(`${PATHS.templates.swiftui}/icons/AssetContents.json`)),
);
gulp.task(
  'template',
  gulp.series(
    'generate-icon-names',
    generateUIKit(parseUIKitTokens(tokens)),
    generateSwiftUI(parseSwiftUITokens(tokens))
  )
);

gulp.task('default', gulp.series('template'));
gulp.task('clean', () => del([PATHS.output], { force: true }));

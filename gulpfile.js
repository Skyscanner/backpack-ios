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
const merge2 = require('merge2');
const _ = require('lodash');
const tokens = require('@skyscanner/bpk-foundations-ios/tokens/base.ios.json');
const { fontTokens } = require('./scripts/gulp/fonts');
const borderWidths = require('./scripts/gulp/borderWidths');
const { radiiTokens } = require('./scripts/gulp/radii');
const shadows = require('./scripts/gulp/shadows');
const colors = require('./scripts/gulp/colours');
const durations = require('./scripts/gulp/durations');
const { spacingTokens } = require('./scripts/gulp/spacings');
const dynamicColors = require('./scripts/gulp/dynamicColours');
const internalColors = require('./scripts/gulp/internalColours');
const getLegibleName = require('./scripts/gulp/utils/legibleName');
const { formatPrefixedConstName, hasOldSemanticSuffix, parseColor } = require('./scripts/gulp/utils/formatUtils');
const objectiveC = require('./scripts/gulp/generation/objc');
const swiftUI = require('./scripts/gulp/generation/swiftui');
const generateSvgIcons = require('./scripts/gulp/generation/iconSvgs');
const generateIconNamesSwiftUI = require('./scripts/gulp/generation/swiftui/icons');
const { generateIconNamesUIKit, generateIconExampleUtil, generateIconExampleTestsUtil } = require('./scripts/gulp/generation/uikit/icons');
const generateAutoMirrorIconNames = require('./scripts/gulp/autoMirrorIconNames');

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
    ...internalColors(properties),
    ...fontTokens.swiftui(properties),
    ...colors(properties, entry => !hasOldSemanticSuffix(entry)),
    ...shadows(properties, parseColor, getLegibleName),
  ])
    .groupBy(({ type }) => type)
    .value();
};

const parseUIKitTokens = (tokensData) => {
  const properties = tokensData.properties
  return _.chain([
    ...dynamicColors(properties),
    ...internalColors(properties),
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

gulp.task('generate-icons', gulp.series(
  generateIconNamesSwiftUI(PATHS.templates.swiftui),
  generateIconNamesUIKit(PATHS.output, PATHS.templates.objc),
  generateIconExampleUtil(PATHS.templates.objc),
  generateIconExampleTestsUtil(PATHS.templates.objc, PATHS.templates.swiftui),
  generateSvgIcons(`${PATHS.templates.objc}/icons/AssetContents.json`),
  generateAutoMirrorIconNames(PATHS.templates.objc)),
);

gulp.task(
  'template',
  gulp.series(
    'generate-icons',
    generateUIKit(parseUIKitTokens(tokens)),
    generateSwiftUI(parseSwiftUITokens(tokens))
  )
);

gulp.task('default', gulp.series('template'));

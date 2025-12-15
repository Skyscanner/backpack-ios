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
const data = require('gulp-data');
const rename = require('gulp-rename');
const { iconsUIKit, iconsSwiftUI } = require('../../iconNames');

// Load the ESM-only gulp-nunjucks from CJS via dynamic import
const getNunjucksCompile = async () => (await import('gulp-nunjucks')).nunjucksCompile;

// Helper to wait for a stream to finish when we need to coordinate multiple streams
const waitForStream = (stream) =>
  new Promise((resolve, reject) => {
    stream.on('error', reject);
    stream.on('finish', resolve);
    stream.on('end', resolve);
  });

// Filtered list for the examples screen (unchanged)
const iconsForExamples = Object.keys(
  require('@skyscanner/bpk-svgs/dist/iconMapping.json')
).filter((iconName) => !iconName.endsWith('-xl') && !iconName.endsWith('-xxxl'));

// Generic generator (now async) that returns the stream.
// It compiles using gulp-nunjucks v6's nunjucksCompile() named export.
const generateFromTemplate = async (template, templateData, renameTo, destination) => {
  const nunjucksCompile = await getNunjucksCompile();
  return gulp
    .src(template)
    .pipe(data(templateData))
    .pipe(nunjucksCompile())
    .pipe(rename(renameTo))
    .pipe(gulp.dest(destination));
};

// Generate UIKit icon name files
const generateIconNamesUIKit = (output, templatesFolder) => async () => {
  const renameTo = (file) => {
    // eslint-disable-next-line no-param-reassign
    file.extname = '';
  };

  const allTemplates = path.join(
    templatesFolder,
    '{BPKIconNames.h.njk,BPKIcons.swift.njk,BPKIconNames.m.njk,BPKSmallIconNames.h.njk,BPKSmallIconNames.m.njk,BPKLargeIconNames.h.njk,BPKLargeIconNames.m.njk}'
  );

  return generateFromTemplate(
    allTemplates,
    iconsUIKit(),
    renameTo,
    path.join(output, 'Icon', 'Classes', 'Generated')
  );
};

// Create helper for icons example screen
const generateIconExampleUtil = (templatesFolder) => async () => {
  return generateFromTemplate(
    path.join(templatesFolder, 'icons/BPKIconsExampleUtil.njk'),
    {
      icons: iconsForExamples,
      iconNames: iconsSwiftUI().icons.map((i) => i.name),
    },
    'BPKIconsExampleUtil.swift',
    'Example/Backpack/SwiftUI/Components/Icons/Generated'
  );
};

// Create helpers for icons tests (UIKit + SwiftUI)
// We return a Promise that resolves once both output streams have finished.
const generateIconExampleTestsUtil = (uikitTemplatesFolder, swiftuiTemplatesFolder) => async () => {
  const s1 = await generateFromTemplate(
    path.join(uikitTemplatesFolder, 'icons/BPKIconsExampleTestsUtil.njk'),
    { icons: iconsForExamples },
    'BPKIconsTestsUtils.swift',
    'Backpack/Tests/SnapshotTests/Utils'
  );

  const s2 = await generateFromTemplate(
    path.join(swiftuiTemplatesFolder, 'IconsTestsUtils.njk'),
    { iconNames: iconsSwiftUI().icons.map((i) => i.name) },
    'IconsTestsUtils.swift',
    'Backpack-SwiftUI/Tests/Icons/Generated'
  );

  await Promise.all([waitForStream(s1), waitForStream(s2)]);
};

module.exports = {
  generateIconNamesUIKit,
  generateIconExampleUtil,
  generateIconExampleTestsUtil,
};
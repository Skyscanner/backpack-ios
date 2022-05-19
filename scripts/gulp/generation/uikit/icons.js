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
const { iconsUIKit, iconsSwiftUI } = require('../../iconNames');

const iconsForExamples = Object.keys(require('@skyscanner/bpk-svgs/dist/font/iconMapping.json'))
  .filter(iconName => !iconName.endsWith('-xl'))

const generateFromTemplate = (template, templateData, renameTo, destination) => {
  gulp
    .src(template)
    .pipe(data(templateData))
    .pipe(nunjucks.compile())
    .pipe(rename(renameTo))
    .pipe(gulp.dest(destination))
}

const generateIconNamesUIKit = (output, templatesFolder) => (done) => {
  const renameTo = (file) => {
    // eslint-disable-next-line no-param-reassign
    file.extname = '';
  };
  const allTemplates = path.join(
    templatesFolder,
    `{BPKIconNames.h.njk,BPKIcons.swift.njk,BPKIconNames.m.njk,BPKSmallIconNames.h.njk,BPKSmallIconNames.m.njk,BPKLargeIconNames.h.njk,BPKLargeIconNames.m.njk,BPKXlIconNames.h.njk,BPKXlIconNames.m.njk}`
  );
  generateFromTemplate(
    allTemplates,
    iconsUIKit(),
    renameTo,
    path.join(output, 'Icon', 'Classes', 'Generated')
  )
  done();
};

// Create helper for icons example screen
const generateIconExampleUtil = (templatesFolder) => (done) => {
  generateFromTemplate(
    path.join(templatesFolder, 'icons/BPKIconsExampleUtil.njk'),
    {
      icons: iconsForExamples,
      iconNames: iconsSwiftUI().icons.map(i => i.name)
     },
    'BPKIconsExampleUtil.swift',
    'Example/Backpack/SwiftUI/Components/Icons/Generated'
  )
  done()
};

// Create helper for icons tests
const generateIconExampleTestsUtil = (uikitTemplatesFolder, swiftuiTemplatesFolder) => (done) => {
  generateFromTemplate(
    path.join(uikitTemplatesFolder, 'icons/BPKIconsExampleTestsUtil.njk'),
    { icons: iconsForExamples },
    'BPKIconsTestsUtils.m',
    'Example/SnapshotTests/Utils'
  )

  generateFromTemplate(
    path.join(swiftuiTemplatesFolder, 'IconsTestsUtils.njk'),
    { iconNames: iconsSwiftUI().icons.map(i => i.name) },
    'IconsTestsUtils.swift',
    'Backpack-SwiftUI/Tests/Icons/Generated'
  )
  done()
};

module.exports = {
  generateIconNamesUIKit,
  generateIconExampleUtil,
  generateIconExampleTestsUtil
}
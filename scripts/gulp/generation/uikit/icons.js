const path = require('path');
const data = require('gulp-data');
const gulp = require('gulp');
const nunjucks = require('gulp-nunjucks');
const rename = require('gulp-rename');
const { iconsUIKit } = require('../../iconNames');

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
    { icons: iconsForExamples },
    'BPKIconsExampleUtil.swift',
    'Example/Backpack/ViewControllers/Icons/Generated'
  )
  done()
};

// Create helper for icons tests
const generateIconExampleTestsUtil = (templatesFolder) => (done) => {
  generateFromTemplate(
    path.join(templatesFolder, 'icons/BPKIconsExampleTestsUtil.njk'),
    { icons: iconsForExamples },
    'BPKIconsTestsUtils.m',
    'Example/SnapshotTests/Utils/'
  )
  done()
};

module.exports = {
  generateIconNamesUIKit,
  generateIconExampleUtil,
  generateIconExampleTestsUtil
}
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

const gulp = require('gulp');
const nunjucks = require('gulp-nunjucks');
const data = require('gulp-data');
const rename = require('gulp-rename');
const merge2 = require('merge2');
const del = require('del');
const path = require('path');
const _ = require('lodash');
const tinycolor = require('tinycolor2');
const tokens = require('bpk-tokens/tokens/base.ios.json');
const fs = require('fs');

const PATHS = {
  templates: path.join(__dirname, 'templates'),
  output: path.join(__dirname, 'Backpack'),
};

const TYPES = new Set(['color', 'font', 'spacing', 'radii', 'shadow']);
const VALID_TEXT_STYLES = new Set(['xs', 'sm', 'base', 'lg', 'xl']);
const VALID_SPACINGS = new Set(['none', 'sm', 'md', 'base', 'lg', 'xl', 'xxl']);
const WEIGHT_MAP = {
  normal: 'UIFontWeightRegular',
  bold: 'UIFontWeightBold',
  100: 'UIFontWeightUltraLight',
  200: 'UIFontWeightThin',
  300: 'UIFontWeightLight',
  400: 'UIFontWeightRegular',
  500: 'UIFontWeightMedium',
  600: 'UIFontWeightSemibold',
  700: 'UIFontWeightBold',
  800: 'UIFontWeightHeavy',
  900: 'UIFontWeightBlack',
};
const LEGIBLE_NAMES = [
  { identifier: 'Sm', legibleName: 'small' },
  { identifier: 'Md', legibleName: 'medium' },
  { identifier: 'Base', legibleName: 'base' },
  { identifier: 'Lg', legibleName: 'large' },
  { identifier: 'Xl', legibleName: 'extra large' },
  { identifier: 'Xxl', legibleName: 'extra extra large' },
  { identifier: 'Pill', legibleName: 'pill' },
  { identifier: 'None', legibleName: 'none' },
];

function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

const getLegibleName = name => {
  let result = null;
  LEGIBLE_NAMES.forEach(t => {
    if (name.includes(t.identifier)) {
      result = t.legibleName;
    }
  });
  if (result) {
    return result;
  }
  throw new Error(`No legible name found for ${name}`);
};

const parseColor = color => {
  const parsedColor = tinycolor(color);

  const { r, g, b, a } = parsedColor.toRgb();

  return {
    r: (r / 255.0).toFixed(3),
    g: (g / 255.0).toFixed(3),
    b: (b / 255.0).toFixed(3),
    a,
  };
};

const convertFontWeight = weightString => {
  const weight = WEIGHT_MAP[weightString.trim()];

  if (!weight) {
    throw new Error(`Invalid weight string \`${weightString}\``);
  }

  return weight;
};

const generatePrefixedConst = ({ name, ...rest }) => {
  const capitalize = input => input.charAt(0).toUpperCase() + input.slice(1);
  return {
    name: `BPK${capitalize(name)}`,
    ...rest,
  };
};

const parseTokens = tokensData => {
  const colors = _.chain(tokensData.properties)
    .filter(({ type }) => type === 'color')
    .map(({ value, name, ...rest }) => {
      const newName = name.replace('color', '');
      return {
        value: parseColor(value),
        name: newName[0].toLowerCase() + newName.slice(1),
        hex: value.toString(),
        ...rest,
      };
    })
    .value();

  const emphazisedWeight = convertFontWeight(
    _.filter(
      tokensData.properties,
      ({ name }) => name === 'textEmphasizedFontWeight',
    )[0].value,
  );

  const fonts = _.chain(tokensData.properties)
    .filter(
      ({ category }) =>
        category === 'font-sizes' || category === 'font-weights',
    )
    .groupBy(({ name }) =>
      name.replace('FontSize', '').replace('FontWeight', ''),
    )
    .map((values, key) => [values, key])
    .filter(token =>
      VALID_TEXT_STYLES.has(token[1].replace('text', '').toLowerCase()),
    )
    .map(token => {
      const properties = token[0];
      const key = token[1];

      const sizeProp = _.filter(
        properties,
        ({ category }) => category === 'font-sizes',
      );
      const weightProp = _.filter(
        properties,
        ({ category }) => category === 'font-weights',
      );

      if (sizeProp.length !== 1 || weightProp.length !== 1) {
        throw new Error(
          'Expected all text sizes to have both a weight and font size',
        );
      }

      return {
        name: key,
        enumName: `BPKFontStyle${_.upperFirst(key)}`,
        size: Number.parseInt(sizeProp[0].value, 10),
        weight: convertFontWeight(weightProp[0].value),
        type: 'font',
      };
    })
    .flatMap(properties => [
      properties,
      {
        ...properties,
        weight: emphazisedWeight,
        name: `${properties.name}Emphasized`,
        enumName: `${properties.enumName}Emphasized`,
      },
    ])
    .sortBy(['name'])
    .value();

  const spacings = _.chain(tokensData.properties)
    .filter(({ category }) => category === 'spacings')
    .filter(({ name }) =>
      VALID_SPACINGS.has(name.replace('spacing', '').toLowerCase()),
    )
    .map(({ name, value }) =>
      generatePrefixedConst({
        type: 'spacing',
        name,
        value,
        legibleName: getLegibleName(name),
      }),
    )
    .value();

  const shadows = _.chain(tokensData.properties)
    .filter(({ category }) => category === 'box-shadows')
    .groupBy(({ name }) =>
      name
        .replace('OffsetHeight', '')
        .replace('OffsetWidth', '')
        .replace('Opacity', '')
        .replace('Radius', '')
        .replace('Color', ''),
    )
    .map((values, key) => [values, key])
    .map(([properties, key]) => {
      const findByName = name => ({ name: packageName }) =>
        packageName === name;
      const offsetHeightProp = _.filter(
        properties,
        findByName(`${key}OffsetHeight`),
      );
      const offsetWidthProp = _.filter(
        properties,
        findByName(`${key}OffsetWidth`),
      );
      const opacityProp = _.filter(properties, findByName(`${key}Opacity`));
      const radiusProp = _.filter(properties, findByName(`${key}Radius`));
      const colorProp = _.filter(properties, findByName(`${key}Color`));

      if (
        offsetHeightProp.length === 0 ||
        offsetWidthProp.length === 0 ||
        opacityProp.length === 0 ||
        radiusProp.length === 0 ||
        colorProp.length === 0
      ) {
        throw new Error(
          `Expected all shadow definitions to have offset, opacity, radius and color. ${key} did not`,
        );
      }

      return {
        name: key,
        type: 'shadow',
        offset: {
          x: offsetWidthProp[0].value,
          y: offsetHeightProp[0].value,
        },
        color: parseColor(colorProp[0].value),
        opacity: opacityProp[0].value,
        radius: radiusProp[0].value,
        legibleName: getLegibleName(key),
      };
    })
    .value();

  const radii = _.chain(tokensData.properties)
    .filter(({ category }) => category === 'radii')
    .map(({ name, value }) =>
      generatePrefixedConst({
        type: 'radii',
        name,
        value,
        legibleName: getLegibleName(name),
      }),
    )
    .value();

  return _.chain([...colors, ...fonts, ...spacings, ...radii, ...shadows])
    .groupBy(({ type }) => type)
    .value();
};

gulp.task('template', () => {
  const streams = [];
  const templateData = parseTokens(tokens);

  // eslint-disable-next-line no-restricted-syntax
  for (const type of TYPES) {
    const processedType = capitalizeFirstLetter(type);

    streams.push(
      gulp
        .src(path.join(PATHS.templates, `BPK${processedType}.h.njk`))
        .pipe(data(() => templateData))
        .pipe(nunjucks.compile())
        .pipe(
          rename(`${processedType}/Classes/Generated/BPK${processedType}.h`),
        ),
    );

    streams.push(
      gulp
        .src(path.join(PATHS.templates, `BPK${processedType}.m.njk`))
        .pipe(data(() => templateData))
        .pipe(nunjucks.compile())
        .pipe(
          rename(`${processedType}/Classes/Generated/BPK${processedType}.m`),
        ),
    );
  }

  return merge2(streams).pipe(gulp.dest(PATHS.output));
});

gulp.task('copy-icon-font', () => {
  gulp
    .src('node_modules/bpk-svgs/dist/font/{BpkIcon.ttf,iconMapping.json}')
    .pipe(gulp.dest(path.join(PATHS.output, 'Icon', 'Assets')));
});

gulp.task('generate-icon-names', () => {
  const content = JSON.parse(
    fs.readFileSync('node_modules/bpk-svgs/dist/font/iconMapping.json'),
  );
  const codify = name =>
    name
      .replace('--', '-')
      .split('-')
      .map(capitalizeFirstLetter)
      .join('')
      .replace('Ios', 'iOS');
  const templateData = Object.assign(
    ...Object.entries(content).map(([k]) => ({ [k]: codify(k) })),
  );

  gulp
    .src(path.join(PATHS.templates, `{BPKIconNames.h.njk,BPKIconNames.m.njk}`))
    .pipe(data(() => ({ icons: templateData })))
    .pipe(nunjucks.compile())
    .pipe(
      rename(file => {
        // eslint-disable-next-line no-param-reassign
        file.extname = '';
      }),
    )
    .pipe(gulp.dest(path.join(PATHS.output, 'Icon', 'Classes', 'Generated')));
});

gulp.task('default', ['template', 'copy-icon-font', 'generate-icon-names']);
gulp.task('clean', () => del([PATHS.output], { force: true }));

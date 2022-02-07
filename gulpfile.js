/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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
const fs = require('fs');

const gulp = require('gulp');
const nunjucks = require('gulp-nunjucks');
const data = require('gulp-data');
const rename = require('gulp-rename');
const merge2 = require('merge2');
const del = require('del');
const _ = require('lodash');
const tinycolor = require('tinycolor2');
const tokens = require('@skyscanner/bpk-foundations-ios/tokens/base.ios.json');

const PATHS = {
  templates: path.join(__dirname, 'templates'),
  output: path.join(__dirname, 'Backpack'),
};

const TYPES = new Set([
  'color',
  'font',
  'spacing',
  'radii',
  'borderWidth',
  'shadow',
  'duration',
]);
const VALID_SHADOWS = new Set(['sm', 'lg']);
const VALID_SPACINGS = new Set([
  'none',
  'sm',
  'md',
  'base',
  'lg',
  'xl',
  'xxl',
  'icontext',
]);
const VALID_RADII = new Set(['xs', 'sm', 'md', 'lg', 'pill']);
const VALID_BORDER_WIDTHS = new Set(['sm', 'lg', 'xl']);
const WEIGHT_MAP = {
  400: 'UIFontWeightRegular',
  700: 'UIFontWeightBold',
  900: 'UIFontWeightBlack',
};
const LEGIBLE_NAMES = [
  { identifier: 'Xs', legibleName: 'extra small' },
  { identifier: 'Sm', legibleName: 'small' },
  { identifier: 'Md', legibleName: 'medium' },
  { identifier: 'Base', legibleName: 'base' },
  { identifier: 'BaseTight', legibleName: 'base tight' },
  { identifier: 'Lg', legibleName: 'large' },
  { identifier: 'LgTight', legibleName: 'large tight' },
  { identifier: 'Xl', legibleName: 'extra large' },
  { identifier: 'XlTight', legibleName: 'extra large tight' },
  { identifier: 'Xxl', legibleName: 'extra extra large' },
  { identifier: 'Xxxl', legibleName: 'extra extra extra large' },
  { identifier: 'Xxxxl', legibleName: 'extra extra extra extra large' },
  { identifier: '5Xl', legibleName: '5 extra large' },
  { identifier: '6Xl', legibleName: '6 extra large' },
  { identifier: '7Xl', legibleName: '7 extra large' },
  { identifier: '8Xl', legibleName: '8 extra large' },
  { identifier: 'Pill', legibleName: 'pill' },
  { identifier: 'None', legibleName: 'none' },
  { identifier: 'IconText', legibleName: 'icon text' },
];

// NOTE: These values MUST be stable and any change
// other than introducing new unique values is a breaking change.
const FONT_ENUM_VALUES = {
  BPKFontStyleTextBase: 0,
  BPKFontStyleTextBaseEmphasized: 1,

  BPKFontStyleTextLg: 2,
  BPKFontStyleTextLgEmphasized: 3,

  BPKFontStyleTextSm: 4,
  BPKFontStyleTextSmEmphasized: 5,

  BPKFontStyleTextXl: 6,
  BPKFontStyleTextXlEmphasized: 7,
  BPKFontStyleTextXlHeavy: 10,

  BPKFontStyleTextXs: 8,
  BPKFontStyleTextXsEmphasized: 9,

  BPKFontStyleTextCaps: 11,
  BPKFontStyleTextCapsEmphasized: 12,

  BPKFontStyleTextXxl: 13,
  BPKFontStyleTextXxlEmphasized: 14,
  BPKFontStyleTextXxlHeavy: 15,

  BPKFontStyleTextXxxl: 16,
  BPKFontStyleTextXxxlEmphasized: 17,
  BPKFontStyleTextXxxlHeavy: 18,

  BPKFontStyleTextHero1: 19,
  BPKFontStyleTextHero2: 20,
  BPKFontStyleTextHero3: 21,
  BPKFontStyleTextHero4: 22,
  BPKFontStyleTextHero5: 23,

  BPKFontStyleTextHeading5: 24,
  BPKFontStyleTextHeading4: 25,
  BPKFontStyleTextHeading3: 26,
  BPKFontStyleTextHeading2: 27,
  BPKFontStyleTextHeading1: 28,

  BPKFontStyleTextSubheading: 29,
  BPKFontStyleTextBodyLongform: 30,
  BPKFontStyleTextBodyDefault: 31,

  BPKFontStyleTextLabel2: 32,
  BPKFontStyleTextLabel1: 33,

  BPKFontStyleTextFootnote: 34,
  BPKFontStyleTextCaption: 35,
};
const format = (s) => s[0].toUpperCase() + _.camelCase(s.substring(1));

const enumValueForName = (name) => {
  const enumValue = FONT_ENUM_VALUES[name];
  if (typeof enumValue !== 'number') {
    throw new Error(
      `No font enum value found for \`${name}\` in \`FONT_ENUM_VALUES\`. Every font variant MUST have a value in this object`,
    );
  }

  return enumValue;
};

const getLegibleName = (name) => {
  let result = null;
  LEGIBLE_NAMES.forEach((t) => {
    if (name.includes(t.identifier)) {
      result = t.legibleName;
    }
  });
  if (result) {
    return result;
  }
  throw new Error(`No legible name found for ${name}`);
};

const parseDuration = (duration) => {
  const ms = parseInt(duration.replace('ms', ''), 10);
  return ms / 1000;
};

const parseColor = (color) => {
  const parsedColor = tinycolor(color);

  const { r, g, b, a } = parsedColor.toRgb();

  return {
    r255: r,
    g255: g,
    b255: b,
    r: (r / 255.0).toFixed(3),
    g: (g / 255.0).toFixed(3),
    b: (b / 255.0).toFixed(3),
    a,
  };
};

const convertFontWeight = (weightString) => {
  const weight = WEIGHT_MAP[weightString.trim()];

  if (!weight) {
    throw new Error(`Invalid weight string \`${weightString}\``);
  }

  return weight;
};

const generatePrefixedConst = ({ name, ...rest }) => {
  return {
    name: formatPrefixedConstName(name),
    ...rest,
  };
};

const isDynamicColor = (entity) => entity.value && entity.darkValue;

const formatPrefixedConstName = (name) => `BPK${name.charAt(0).toUpperCase()}${name.slice(1)}`

const parseTokens = (tokensData) => {
  /* eslint-disable no-unused-vars */
  const dynamicColors = _.chain(tokensData.properties)
    .filter((entity) => entity.type === 'color' && isDynamicColor(entity))
    .map(
      ({
        value,
        originalValue,
        darkValue,
        originalDarkValue,
        name,
        type,
        ...rest
      }) => ({
        value: _.camelCase(originalValue),
        darkValue: _.camelCase(originalDarkValue),
        name: name[0].toLowerCase() + name.slice(1),
        hex: value.toString(),
        darkHex: darkValue.toString(),
        type: 'dynamicColor',
        ...rest,
      }),
    )
    .value();
  /* eslint-enable no-unused-vars */

  const colors = _.chain(tokensData.properties)
    .filter((entity) => entity.type === 'color' && !isDynamicColor(entity))
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

  // eslint-disable-next-line no-unused-vars
  colors.forEach(({ value, name, hex, type, ...rest }) => {
    const matchingValueColors = colors.filter(
      (c) => c.type === 'valueColor' && c.hex === hex && c.name !== name,
    );
    if (matchingValueColors.length > 0) {
      colors.push({
        value,
        name,
        hex,
        reference: matchingValueColors[0].name,
        type: 'referenceColor',
        ...rest,
      });
    } else {
      colors.push({
        value,
        name,
        hex,
        type: 'valueColor',
        ...rest,
      });
    }
  });

  const durations = _.chain(tokensData.properties)
    .filter(({ type }) => type === 'duration')
    .map(({ value, name, ...rest }) => ({
      value: parseDuration(value),
      name,
      ...rest,
    }))
    .value();

  const fonts = _.chain(tokensData.properties)
    .filter(
      ({ category }) =>
        category === 'font-sizes' ||
        category === 'font-weights' ||
        category === 'typesettings' ||
        category === 'letter-spacings',
    )
    .groupBy(({ name }) =>
      name
        .replace('FontSize', '')
        .replace('FontWeight', '')
        .replace('LetterSpacing', '')
        .replace('LineHeight', ''),
    )
    .map((values, key) => [values, key])
    .filter((token) => {
      return token[1].startsWith('text')
    })
    .map((token) => {
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

      const lineHeightProp = _.filter(
        properties,
        ({ category }) => category === 'typesettings',
      );

      const letterSpacingProp = _.filter(
        properties,
        ({ category }) => category === 'letter-spacings',
      );

      if (sizeProp.length !== 1 || weightProp.length !== 1) {
        throw new Error(
          `Expected all text sizes to have line height, letter spacing, weight, and font size. Not all were found for ${key}`,
        );
      }
      const enumName = `BPKFontStyle${_.upperFirst(key)}`;
      const letterSpacingFor = prop => {
        if (!prop || !prop.value || prop.type.includes('legacy')) { return null }
        const adjustedValue = Number.parseFloat(prop.value) * 100
        return {
          value: adjustedValue,
          name: prop.originalValue.replace('{!', '').replace('}', '').replace('LETTER_SPACING_', '')
        }
      }

      const lineHeightFor = prop => {
        if (!prop) { return null }
        return {
          value: Number.parseInt(prop.value, 10),
          name: prop.originalValue.replace('{!', '').replace('}', '').replace('LINE_HEIGHT_', '')
        }
      }

      return {
        name: key,
        enumName,
        enumValue: enumValueForName(enumName),
        size: Number.parseInt(sizeProp[0].value, 10),
        weight: convertFontWeight(weightProp[0].value),
        type: 'font',
        lineHeight: lineHeightFor(lineHeightProp[0]),
        letterSpacing: letterSpacingFor(letterSpacingProp[0])
      };
    })
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
    .sortBy((s) => parseInt(s.value, 10))
    .value();

  const shadows = _.chain(tokensData.properties)
    .filter(({ category }) => category === 'box-shadows')
    .filter(({ name }) => {
      const size = name
        .replace('shadow', '')
        .replace('Color', '')
        .replace('OffsetHeight', '')
        .replace('OffsetWidth', '')
        .replace('Opacity', '')
        .replace('Radius', '');
      return VALID_SHADOWS.has(size.toLowerCase());
    })
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
      const findByName = (name) => ({ name: packageName }) =>
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
    .filter(({ name }) =>
      VALID_RADII.has(name.replace('cornerRadius', '').toLowerCase()),
    )
    .map(({ name, value }) =>
      generatePrefixedConst({
        type: 'radii',
        name,
        value,
        legibleName: getLegibleName(name),
      }),
    )
    .value();

  const borderWidths = _.chain(tokensData.properties)
    .filter(({ category }) => category === 'borders')
    .filter(({ name }) =>
      VALID_BORDER_WIDTHS.has(name.replace('borderWidth', '').toLowerCase()),
    )
    .map(({ name, value }) =>
      generatePrefixedConst({
        type: 'borders',
        name,
        value,
        legibleName: getLegibleName(name),
      }),
    )
    .value();

  return _.chain([
    ...dynamicColors,
    ...colors,
    ...fonts,
    ...spacings,
    ...radii,
    ...borderWidths,
    ...shadows,
    ...durations,
  ])
    .groupBy(({ type }) => type)
    .value();
};

gulp.task('generate-icon-names', (done) => {
  const content = JSON.parse(
    fs.readFileSync('node_modules/@skyscanner/bpk-svgs/dist/font/iconMapping.json'),
  );
  const combinedEntries = Object.entries(content).filter(
    (x) => !x[0].endsWith('-sm'),
  );
  const smallEntries = Object.entries(content).filter((x) =>
    x[0].endsWith('-sm'),
  );
  const largeEntries = Object.entries(content).filter(
    (x) => !x[0].endsWith('-sm') && !x[0].endsWith('-xl'),
  );
  const xlEntries = Object.entries(content).filter((x) => x[0].endsWith('-xl'));

  const codify = (name) =>
    name
      .replace('--', '-')
      .split('-')
      .map(format)
      .join('')
      .replace('Ios', 'iOS');

  // Once we drop support for the legacy API, we can leave the suffix in the string
  // so that `BPKIcon.m` doesn't need to add it back in programmatically
  const templateData = (entries, suffix = '') =>
    Object.assign(
      ...entries.map(([k]) => {
        const key = k.endsWith(suffix)
          ? k.substring(0, k.length - suffix.length)
          : k;
        return {
          [key]: codify(key),
        };
      }),
    );

  gulp
    .src(
      path.join(
        PATHS.templates,
        `{BPKIconNames.h.njk,BPKIconNames.m.njk,BPKSmallIconNames.h.njk,BPKSmallIconNames.m.njk,BPKLargeIconNames.h.njk,BPKLargeIconNames.m.njk,BPKXlIconNames.h.njk,BPKXlIconNames.m.njk}`,
      ),
    )
    .pipe(
      data(() => ({
        icons: templateData(combinedEntries),
        smallIcons: templateData(smallEntries, '-sm'),
        largeIcons: templateData(largeEntries),
        xlIcons: templateData(xlEntries, '-xl'),
      })),
    )
    .pipe(nunjucks.compile())
    .pipe(
      rename((file) => {
        // eslint-disable-next-line no-param-reassign
        file.extname = '';
      }),
    )
    .pipe(gulp.dest(path.join(PATHS.output, 'Icon', 'Classes', 'Generated')));
  done();
});

gulp.task(
  'template',
  gulp.series('generate-icon-names', () => {
    const streams = [];
    const templateData = parseTokens(tokens);

    // eslint-disable-next-line no-restricted-syntax
    for (const type of TYPES) {
      const processedType = format(type);

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

    streams.push(
      gulp
        .src(path.join(PATHS.templates, 'UIColor+Backpack.h.njk'))
        .pipe(data(() => templateData))
        .pipe(nunjucks.compile())
        .pipe(rename('Color/Classes/Generated/UIColor+Backpack.h')),
    );

    streams.push(
      gulp
        .src(path.join(PATHS.templates, 'UIColor+Backpack.m.njk'))
        .pipe(data(() => templateData))
        .pipe(nunjucks.compile())
        .pipe(rename('Color/Classes/Generated/UIColor+Backpack.m')),
    );

    return merge2(streams).pipe(gulp.dest(PATHS.output));
  }),
);

gulp.task('copy-icon-font', (done) => {
  merge2([
    gulp.src('node_modules/@skyscanner/bpk-svgs/dist/font/BpkIconIOS.ttf').pipe(
      rename({
        basename: 'BpkIconIOS',
      }),
    ),
    gulp.src('node_modules/@skyscanner/bpk-svgs/dist/font/iconMapping.json'),
  ]).pipe(gulp.dest(path.join(PATHS.output, 'Icon', 'Assets')));
  done();
});

gulp.task('default', gulp.series('template', 'copy-icon-font'));
gulp.task('clean', () => del([PATHS.output], { force: true }));

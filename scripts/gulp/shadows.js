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

const _ = require('lodash');
const { lowercaseFirstLetter } = require('./utils/formatUtils');

const VALID_SHADOWS = new Set(['sm', 'lg']);

const shadows = (properties, parseColor, getLegibleName) => _.chain(properties)
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
      swiftuiName: lowercaseFirstLetter(key.replace('shadow', '')),
      swiftuiColorName: lowercaseFirstLetter(key.replace('shadow', '')),
      legibleName: getLegibleName(key),
    };
  })
  .value();

module.exports = shadows
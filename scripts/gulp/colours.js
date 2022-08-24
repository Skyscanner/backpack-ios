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
const { isSemanticColor, isMarcommsColor, hasNewSemanticSuffix, hasOldSemanticSuffix, parseColor } = require('./utils/formatUtils');

const colors = (properties, filterColors) => {
  const colors = _.chain(properties)
    .filter((entity) => entity.type === 'color')
    .filter(entry => !isSemanticColor(entry) && !hasNewSemanticSuffix(entry) && !isMarcommsColor(entry))
    .map(({ value, name, ...rest }) => {
      const newName = name.replace('color', '');
      return {
        value: parseColor(value),
        name: newName[0].toLowerCase() + newName.slice(1),
        hex: value.toString(),
        ...rest,
      };
    })
    .filter(entity => filterColors ? filterColors(entity) : entity)
    .value();

  colors.forEach(({ value, name, hex, ...rest }) => {
    const matchingValueColors = colors.filter(
      (c) => c.type === 'valueColor' && c.hex === hex && c.name !== name,
    );
    if (matchingValueColors.length > 0) {
      colors.push({
        value,
        name,
        hex,
        reference: matchingValueColors[0].name,
        ...rest,
        type: 'referenceColor',
      });
    } else {
      colors.push({
        value,
        name,
        hex,
        ...rest,
        type: 'valueColor',
      });
    }
  });
  return colors
}

module.exports = colors
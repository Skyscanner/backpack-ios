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
const { hasNewSemanticSuffix, isPrivateColor, parseColor } = require('./utils/formatUtils');

const internalColors = (properties) => _.chain(properties)
  .filter((entity) => entity.type === 'color' && isPrivateColor(entity) && !hasNewSemanticSuffix(entity))
  .map(
    ({
      name,
      ...rest
    }) => ({
      name: name.replace('private', ''),
      ...rest
    })
  )
  .map(
    ({
      value,
      darkValue,
      name,
      ...rest
    }) => {
      const parsedValue = parseColor(value);
      const parsedDarkValue = parseColor(darkValue !== undefined ? darkValue : value);
      const swiftName = name[0].toLowerCase() + name.slice(1);
      return {
        value: parsedValue,
        darkValue: parsedDarkValue,
        name: swiftName,
        objcName: `internal${name}`,
        hex: value.toString(),
        darkHex: (darkValue !== undefined ? darkValue : value).toString(),
        ...rest,
        type: 'internalColor',
      };
    },
  )
  .value();

module.exports = internalColors

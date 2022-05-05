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
const { formatPrefixedConstName, lowercaseFirstLetter } = require('./utils/formatUtils');
const getLegibleName = require('./utils/legibleName');

const VALID_RADII = new Set(['xs', 'sm', 'md', 'lg', 'pill']);

const radii = (properties, formatName) => _.chain(properties)
  .filter(({ category }) => category === 'radii')
  .filter(({ name }) =>
    VALID_RADII.has(name.replace('cornerRadius', '').toLowerCase()),
  )
  .map(({ name, value }) => {
    return {
      type: 'radii',
      name: formatName(name),
      value,
      legibleName: getLegibleName(name),
    }
  })
  .value();

const radiiUIKit = (properties) => radii(properties, formatPrefixedConstName)
const radiiSwiftUI = (properties) =>
  radii(properties, name => lowercaseFirstLetter(name.replace('cornerRadius', '')))

module.exports = {
  radiiTokens: {
    uikit: radiiUIKit,
    swiftui: radiiSwiftUI
  }
}
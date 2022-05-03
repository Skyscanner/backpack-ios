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
const { lowercaseFirstLetter, formatPrefixedConstName } = require('./utils/formatUtils');
const getLegibleName = require('./utils/legibleName');

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

const filterValidAndMap = (properties, formatName) => _.chain(properties)
  .filter(({ category }) => category === 'spacings')
  .filter(({ name }) =>
    VALID_SPACINGS.has(name.replace('spacing', '').toLowerCase())
  )
  .map(({ name, value }) => ({
    type: 'spacing',
    name: formatName(name),
    value,
    legibleName: getLegibleName(name)
  }))
  .sortBy((s) => parseInt(s.value, 10))
  .value();

const spacingsUIKit = (properties) =>
  filterValidAndMap(properties, formatPrefixedConstName)

const spacingsSwiftUI = (properties) =>
  filterValidAndMap(properties, name => lowercaseFirstLetter(name.replace('spacing', '')))

module.exports = { spacingsUIKit, spacingsSwiftUI }
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

const VALID_BORDER_WIDTHS = new Set(['sm', 'lg', 'xl']);

const borderWidths = (properties, formatName, getLegibleName) => _.chain(properties)
  .filter(({ category }) => category === 'borders')
  .filter(({ name }) =>
    VALID_BORDER_WIDTHS.has(name.replace('borderWidth', '').toLowerCase()),
  )
  .map(({ name, value }) => {
    return {
      type: 'borders',
      name: formatName(name),
      value,
      legibleName: getLegibleName(name),
    }
  })
  .value();

module.exports = borderWidths
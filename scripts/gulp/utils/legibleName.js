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

const LEGIBLE_NAMES = [
  { identifier: 'Xs', legibleName: 'extra small' },
  { identifier: 'Sm', legibleName: 'small' },
  { identifier: 'Md', legibleName: 'medium' },
  { identifier: 'Base', legibleName: 'base' },
  { identifier: 'Lg', legibleName: 'large' },
  { identifier: 'Xl', legibleName: 'extra large' },
  { identifier: 'Xxl', legibleName: 'extra extra large' },
  { identifier: 'Xxxl', legibleName: 'extra extra extra large' },
  { identifier: 'Pill', legibleName: 'pill' },
  { identifier: 'None', legibleName: 'none' },
  { identifier: 'IconText', legibleName: 'icon text' },
];

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

module.exports = getLegibleName
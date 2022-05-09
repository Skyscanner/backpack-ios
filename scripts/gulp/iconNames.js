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

const { lowercaseFirstLetter, capitaliseFirstLetter } = require('./utils/formatUtils');

const iconNames = (format, format2) => {
  const content = require('@skyscanner/bpk-svgs/dist/font/iconMapping.json')
  const combinedEntries = Object.entries(content).filter((x) => !x[0].endsWith('-sm'));
  const smallEntries = Object.entries(content).filter((x) => x[0].endsWith('-sm'));
  const largeEntries = Object.entries(content).filter((x) => !x[0].endsWith('-sm') && !x[0].endsWith('-xl'));
  const xlEntries = Object.entries(content).filter((x) => x[0].endsWith('-xl'));

  const codify = (name) =>
    lowercaseFirstLetter( name
      .replace('--', '-')
      .replace('return', "`return`")
      .split('-')
      .map(capitaliseFirstLetter)
      .join('-')
      .replace('Ios', 'iOS'));

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

  return {
    icons: templateData(combinedEntries),
    smallIcons: templateData(smallEntries, '-sm'),
    largeIcons: templateData(largeEntries),
    xlIcons: templateData(xlEntries, '-xl'),
  }
}

module.exports = iconNames
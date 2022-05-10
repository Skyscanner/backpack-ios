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

const { capitaliseFirstLetter, lowercaseFirstLetter } = require('./utils/formatUtils');

const iconsUIKit = () => {
  const content = require('@skyscanner/bpk-svgs/dist/font/iconMapping.json')
  const combinedEntries = Object.entries(content).filter((x) => !x[0].endsWith('-sm'));
  const smallEntries = Object.entries(content).filter((x) => x[0].endsWith('-sm'));
  const largeEntries = Object.entries(content).filter((x) => !x[0].endsWith('-sm') && !x[0].endsWith('-xl'));
  const xlEntries = Object.entries(content).filter((x) => x[0].endsWith('-xl'));

  const codify = (name) =>
    name
      .replace('--', '-')
      .split('-')
      .map(capitaliseFirstLetter)
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

  return {
    icons: templateData(combinedEntries),
    smallIcons: templateData(smallEntries, '-sm'),
    largeIcons: templateData(largeEntries),
    xlIcons: templateData(xlEntries, '-xl'),
  }
}

const iconsSwiftUI = () => {
  const content = require('@skyscanner/bpk-svgs/dist/font/iconMapping.json')
  const largeEntries = Object.entries(content).filter((x) => !x[0].endsWith('-sm') && !x[0].endsWith('-xl'));

  const codify = (name) =>
    lowercaseFirstLetter(name
      .replace('--', '-')
      .split('-')
      .map(capitaliseFirstLetter)
      .join('')
      .replace('Ios', 'iOS'))

  const templateData = (entries) =>
    entries.map(([key]) => ({
      name: codify(key),
      file: key
    }))
  return {
    icons: templateData(largeEntries)
  }
}

module.exports = {
  iconsUIKit,
  iconsSwiftUI
}
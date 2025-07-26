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
  console.log('🚀 iconsUIKit script starting...');

  const content = require('@skyscanner/bpk-svgs/dist/iconMapping.json');
  console.log(`🔍 Total icons found in iconMapping.json: ${Object.keys(content).length}`);

  const allEntries = Object.entries(content);
  const combinedEntries = allEntries.filter((x) => !x[0].endsWith('-sm'));
  const smallEntries = allEntries.filter((x) => x[0].endsWith('-sm'));
  const largeEntries = allEntries.filter((x) => !x[0].endsWith('-sm') && !x[0].endsWith('-xl') && !x[0].endsWith('-xxl'));
  const xlEntries = allEntries.filter((x) => x[0].endsWith('-xl'));
  const xxlEntries = allEntries.filter((x) => x[0].endsWith('-xxl'));

  console.log(`📦 Combined (all non-small) entries: ${combinedEntries.length}`);
  console.log(`📦 Small icon entries: ${smallEntries.length}`);
  console.log(`📦 Large icon entries: ${largeEntries.length}`);
  console.log(`📦 XL icon entries: ${xlEntries.length}`);
  console.log(`📦 XXL icon entries: ${xxlEntries.length}`);

  const codify = (name) =>
    name
      .replace('--', '-')
      .split('-')
      .map(capitaliseFirstLetter)
      .join('')
      .replace('Ios', 'iOS');

  const templateData = (entries, suffix = '') => {
    if (!Array.isArray(entries)) {
      throw new TypeError('Expected entries to be an array');
    }

    console.log(`🧱 Generating icon mappings (suffix: '${suffix}')...`);
    console.log('📥 Entries passed to templateData:', entries.map(([k]) => k));

    const mapped = entries
      .filter(Boolean)
      .map(([k]) => {
        const key = k.endsWith(suffix)
          ? k.substring(0, k.length - suffix.length)
          : k;
        const result = {
          [key]: codify(key),
        };
        console.log(`🔧 Mapping '${k}' ➡️ '${result[key]}'`);
        return result;
      });

    const output = Object.assign({}, ...mapped);
    console.log(`✅ Finished mapping ${Object.keys(output).length} entries`);
    return output;
  };

  const result = {
    icons: templateData(combinedEntries),
    smallIcons: templateData(smallEntries, '-sm'),
    largeIcons: templateData(largeEntries),
  };

  if (xlEntries.length > 0) {
    console.log('✨ Adding XL icons...');
    result.xlIcons = templateData(xlEntries, '-xl');
  } else {
    console.warn('⚠️ No XL icons found — skipping xlIcons generation.');
  }

  if (xxlEntries.length > 0) {
    console.log('✨ Adding XXL icons...');
    result.xxlIcons = templateData(xxlEntries, '-xxl');
  } else {
    console.warn('⚠️ No XXL icons found — skipping xxlIcons generation.');
  }

  console.log('✅ iconsUIKit processing complete.');
  return result;
};

const iconsSwiftUI = () => {
  console.log('🚀 iconsSwiftUI script starting...');

  const content = require('@skyscanner/bpk-svgs/dist/iconMapping.json');
  const allEntries = Object.entries(content);
  const largeEntries = allEntries.filter((x) => !x[0].endsWith('-sm') && !x[0].endsWith('-xl') && !x[0].endsWith('-xxl'));

  console.log(`📦 SwiftUI Large icon entries: ${largeEntries.length}`);

  const codify = (name) =>
    lowercaseFirstLetter(name
      .replace('--', '-')
      .split('-')
      .map(capitaliseFirstLetter)
      .join('')
      .replace('Ios', 'iOS'));

  const templateData = (entries) =>
    entries.map(([key]) => {
      const formatted = {
        name: codify(key),
        file: key,
      };
      console.log(`🔧 SwiftUI mapping '${key}' ➡️ '${formatted.name}'`);
      return formatted;
    });

  console.log('✅ iconsSwiftUI processing complete.');
  return {
    icons: templateData(largeEntries),
  };
};

module.exports = {
  iconsUIKit,
  iconsSwiftUI,
};

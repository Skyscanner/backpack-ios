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

const rename = require('gulp-rename');

const objectiveC = (generate) => {
  const streams = [
    'Color',
    'Font',
    'Spacing',
    'Radii',
    'BorderWidth',
    'Shadow',
    'Duration',
  ].map(processedType => {
    const destinationPrefix = `${processedType}/Classes/Generated`;
    return {
      files: [
        generate(`BPK${processedType}.h.njk`, rename(`${destinationPrefix}/BPK${processedType}.h`)),
        generate(`BPK${processedType}.m.njk`, rename(`${destinationPrefix}/BPK${processedType}.m`))
      ]
    };
  }).reduce((acc, curVal) => {
    return acc.concat(curVal.files);
  }, []);

  streams.push(generate('UIColor+Backpack.h.njk', rename('Color/Classes/Generated/UIColor+Backpack.h')));
  streams.push(generate('UIColor+Backpack.m.njk', rename('Color/Classes/Generated/UIColor+Backpack.m')));
  return streams;
}

module.exports = objectiveC
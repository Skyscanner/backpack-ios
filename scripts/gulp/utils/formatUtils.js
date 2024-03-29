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
const tinycolor = require('tinycolor2');

const capitaliseFirstLetter = (s) => s[0].toUpperCase() + _.camelCase(s.substring(1));
const lowercaseFirstLetter = (s) => s[0].toLowerCase() + _.camelCase(s.substring(1));

const parseColor = (color) => {
  const { r, g, b, a } = tinycolor(color).toRgb();
  return {
    r255: r,
    g255: g,
    b255: b,
    r: (r / 255.0).toFixed(3),
    g: (g / 255.0).toFixed(3),
    b: (b / 255.0).toFixed(3),
    a,
  };
};

const formatPrefixedConstName = (name) => `BPK${name.charAt(0).toUpperCase()}${name.slice(1)}`

const isSemanticColor = entity => entity.value && entity.darkValue;
const isMarcommsColor = entity => entity.name.startsWith("marcomms")
const hasOldSemanticSuffix = entity => entity.name.toLowerCase().endsWith("lightcolor") || entity.name.toLowerCase().endsWith("darkcolor");
const hasNewSemanticSuffix = entity => entity.name.endsWith("Day") || entity.name.endsWith("Night");
const isPrivateColor = entity => entity.name.startsWith("private");

module.exports = {
  capitaliseFirstLetter,
  lowercaseFirstLetter,
  parseColor,
  isSemanticColor,
  isMarcommsColor,
  hasNewSemanticSuffix,
  hasOldSemanticSuffix,
  formatPrefixedConstName,
  isPrivateColor
}
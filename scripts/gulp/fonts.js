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
const { lowercaseFirstLetter } = require('./utils/formatUtils');

// NOTE: These values MUST be stable and any change
// other than introducing new unique values is a breaking change.
const FONT_ENUM_VALUES = {
    BPKFontStyleTextHero1: 19,
    BPKFontStyleTextHero2: 20,
    BPKFontStyleTextHero3: 21,
    BPKFontStyleTextHero4: 22,
    BPKFontStyleTextHero5: 23,

    BPKFontStyleTextHeading5: 24,
    BPKFontStyleTextHeading4: 25,
    BPKFontStyleTextHeading3: 26,
    BPKFontStyleTextHeading2: 27,
    BPKFontStyleTextHeading1: 28,

    BPKFontStyleTextSubheading: 29,
    BPKFontStyleTextBodyLongform: 30,
    BPKFontStyleTextBodyDefault: 31,

    BPKFontStyleTextLabel3: 36,
    BPKFontStyleTextLabel2: 32,
    BPKFontStyleTextLabel1: 33,

    BPKFontStyleTextFootnote: 34,
    BPKFontStyleTextCaption: 35,
};

const WEIGHT_MAP = {
    400: 'UIFontWeightRegular',
    700: 'UIFontWeightBold',
    900: 'UIFontWeightBlack',
};

const enumValueForName = (name) => {
    const enumValue = FONT_ENUM_VALUES[name];
    if (typeof enumValue !== 'number') {
        throw new Error(
            `No font enum value found for \`${name}\` in \`FONT_ENUM_VALUES\`. Every font variant MUST have a value in this object`,
        );
    }
    return enumValue;
};

const convertFontWeight = (weightString) => {
    const weight = WEIGHT_MAP[weightString.trim()];
    if (!weight) {
        throw new Error(`Invalid weight string \`${weightString}\``);
    }
    return weight;
};

const fonts = properties => _.chain(properties)
    .filter(
        ({ category }) =>
            category === 'font-sizes' ||
            category === 'font-weights' ||
            category === 'typesettings' ||
            category === 'letter-spacings',
    )
    .groupBy(({ name }) =>
        name
            .replace('FontSize', '')
            .replace('FontWeight', '')
            .replace('LetterSpacing', '')
            .replace('LineHeight', ''),
    )
    .map((values, key) => [values, key])
    .filter((token) => {
        return token[1].startsWith('text')
    })
    .filter(props => !props[0].find(p => p.deprecated))
    .map((token) => {
        const properties = token[0];
        const key = token[1];

        const sizeProp = _.filter(
            properties,
            ({ category }) => category === 'font-sizes',
        );
        const weightProp = _.filter(
            properties,
            ({ category }) => category === 'font-weights',
        );

        const lineHeightProp = _.filter(
            properties,
            ({ category }) => category === 'typesettings',
        );

        const letterSpacingProp = _.filter(
            properties,
            ({ category }) => category === 'letter-spacings',
        );

        if (sizeProp.length !== 1 || weightProp.length !== 1) {
            throw new Error(
                `Expected all text sizes to have line height, letter spacing, weight, and font size. Not all were found for ${key}`,
            );
        }
        const enumName = `BPKFontStyle${_.upperFirst(key)}`;
        const letterSpacingFor = prop => {
            if (!prop || !prop.value || prop.type.includes('legacy')) { return null }
            const adjustedValue = Number.parseFloat(prop.value) * 100
            return {
                value: adjustedValue,
                name: prop.originalValue.replace('{!', '').replace('}', '').replace('LETTER_SPACING_', '')
            }
        }

        const lineHeightFor = prop => {
            if (!prop) { return null }
            return {
                value: Number.parseInt(prop.value, 10),
                name: prop.originalValue.replace('{!', '').replace('}', '').replace('LINE_HEIGHT_', '')
            }
        }

        const swiftUIName = (name) => lowercaseFirstLetter(name.replace('text', ''))
        const pr = {
            name: key,
            enumName,
            enumValue: enumValueForName(enumName),
            swiftuiName: swiftUIName(key),
            size: Number.parseInt(sizeProp[0].value, 10),
            weight: convertFontWeight(weightProp[0].value),
            type: 'font',
            lineHeight: lineHeightFor(lineHeightProp[0]),
            letterSpacing: letterSpacingFor(letterSpacingProp[0])
        };
        console.log('pr', pr)
        return pr
    })
    .sortBy(['name'])
    .value();

module.exports = fonts
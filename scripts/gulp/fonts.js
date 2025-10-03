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
    BPKFontStyleTextHero6: 44,

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

    BPKFontStyleTextXsLarken: 37,
    BPKFontStyleTextSmLarken: 38,
    BPKFontStyleTextBaseLarken: 39,

    BPKFontStyleTextDisplay7: 40,

    BPKFontStyleTextEditorial4: 41,
    BPKFontStyleTextEditorial5: 42,
    BPKFontStyleTextEditorial6: 43
};

const WEIGHT_MAP_OBJC = {
    400: 'UIFontWeightRegular',
    700: 'UIFontWeightBold',
    900: 'UIFontWeightBlack',
};

const WEIGHT_MAP_SWIFTUI = {
    400: 'regular',
    700: 'semibold',
    900: 'black'
};

const TEXT_STYLE_MAP_SWIFTUI = {
    BPKFontStyleTextHero1: ".largeTitle",
    BPKFontStyleTextHero2: ".largeTitle",
    BPKFontStyleTextHero3: ".largeTitle",
    BPKFontStyleTextHero4: ".largeTitle",
    BPKFontStyleTextHero5: ".largeTitle",
    BPKFontStyleTextHero6: ".largeTitle",

    BPKFontStyleTextHeading5: ".title3",
    BPKFontStyleTextHeading4: ".title3",
    BPKFontStyleTextHeading3: ".title3",
    BPKFontStyleTextHeading2: ".title2",
    BPKFontStyleTextHeading1: ".title",

    BPKFontStyleTextSubheading: ".subheadline",
    BPKFontStyleTextBodyLongform: ".body",
    BPKFontStyleTextBodyDefault: ".body",

    BPKFontStyleTextLabel3: ".body",
    BPKFontStyleTextLabel2: ".body",
    BPKFontStyleTextLabel1: ".body",

    BPKFontStyleTextFootnote: ".footnote",
    BPKFontStyleTextCaption: ".caption",

    BPKFontStyleTextXsLarken: ".caption",
    BPKFontStyleTextSmLarken: ".footnote",
    BPKFontStyleTextBaseLarken: ".body",

    BPKFontStyleTextDisplay7: ".largeTitle",

    BPKFontStyleTextEditorial4: ".body",
    BPKFontStyleTextEditorial5: ".body",
    BPKFontStyleTextEditorial6: ".body"
}

const TEXT_STYLE_MAP_UIKIT = {
    BPKFontStyleTextHero1: "UIFontTextStyleLargeTitle",
    BPKFontStyleTextHero2: "UIFontTextStyleLargeTitle",
    BPKFontStyleTextHero3: "UIFontTextStyleLargeTitle",
    BPKFontStyleTextHero4: "UIFontTextStyleLargeTitle",
    BPKFontStyleTextHero5: "UIFontTextStyleLargeTitle",
    BPKFontStyleTextHero6: "UIFontTextStyleLargeTitle",

    BPKFontStyleTextHeading5: "UIFontTextStyleTitle3",
    BPKFontStyleTextHeading4: "UIFontTextStyleTitle3",
    BPKFontStyleTextHeading3: "UIFontTextStyleTitle3",
    BPKFontStyleTextHeading2: "UIFontTextStyleTitle2",
    BPKFontStyleTextHeading1: "UIFontTextStyleTitle1",

    BPKFontStyleTextSubheading: "UIFontTextStyleSubheadline",
    BPKFontStyleTextBodyLongform: "UIFontTextStyleBody",
    BPKFontStyleTextBodyDefault: "UIFontTextStyleBody",

    BPKFontStyleTextLabel3: "UIFontTextStyleBody",
    BPKFontStyleTextLabel2: "UIFontTextStyleBody",
    BPKFontStyleTextLabel1: "UIFontTextStyleBody",

    BPKFontStyleTextFootnote: "UIFontTextStyleFootnote",
    BPKFontStyleTextCaption: "UIFontTextStyleCaption1",

    BPKFontStyleTextXsLarken: "UIFontTextStyleCaption1",
    BPKFontStyleTextSmLarken: "UIFontTextStyleFootnote",
    BPKFontStyleTextBaseLarken: "UIFontTextStyleBody",

    BPKFontStyleTextDisplay7: "UIFontTextStyleLargeTitle",

    BPKFontStyleTextEditorial4: "UIFontTextStyleBody",
    BPKFontStyleTextEditorial5: "UIFontTextStyleBody",
    BPKFontStyleTextEditorial6: "UIFontTextStyleBody"
}

const convertFontWeight = (weightMap, weightString) => {
    const weight = weightMap[weightString.trim()];
    if (!weight) {
        throw new Error(`Invalid weight string \`${weightString}\``);
    }
    return weight;
};

const fonts = (properties, mapFont) => _.chain(properties)
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
    .filter(token => token[1].startsWith('text'))
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
        return {
            key,
            properties,
            sizeProp,
            weightProp,
            lineHeightProp,
            letterSpacingProp
        }
    })
    .map(mapFont)
    .sortBy(['name'])
    .value();

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

const uikitFonts = properties => fonts(properties, fontProps => {
        const enumValueForName = (name) => {
            const enumValue = FONT_ENUM_VALUES[name];
            if (typeof enumValue !== 'number') {
                throw new Error(
                    `No font enum value found for \`${name}\` in \`FONT_ENUM_VALUES\`. Every font variant MUST have a value in this object`,
                );
            }
            return enumValue;
        };

        const textStyleValueForName = (name) => {
            const enumValue = TEXT_STYLE_MAP_UIKIT[name];
            if (typeof enumValue !== 'string') {
                throw new Error(
                    `No font enum value found for \`${name}\` in \`TEXT_STYLE_MAP_UIKIT\`. Every font variant MUST have a value in this object`,
                );
            }
            return enumValue;
        };

        const enumName = `BPKFontStyle${_.upperFirst(fontProps.key)}`;

        return {
            name: fontProps.key,
            enumName,
            enumValue: enumValueForName(enumName),
            size: Number.parseInt(fontProps.sizeProp[0].value, 10),
            weight: convertFontWeight(WEIGHT_MAP_OBJC, fontProps.weightProp[0].value),
            type: 'font',
            lineHeight: lineHeightFor(fontProps.lineHeightProp[0]),
            letterSpacing: letterSpacingFor(fontProps.letterSpacingProp[0]),
            textStyle: textStyleValueForName(enumName)
        };
    })

    const swiftuiFonts = properties => fonts(properties, fontProps => {
        const swiftUIName = (name) => lowercaseFirstLetter(name.replace('text', ''))

        const textStyleValueForName = (name) => {
            const enumValue = TEXT_STYLE_MAP_SWIFTUI[name];
            if (typeof enumValue !== 'string') {
                throw new Error(
                    `No font enum value found for \`${name}\` in \`TEXT_STYLE_MAP_SWIFTUI\`. Every font variant MUST have a value in this object`,
                );
            }
            return enumValue;
        };
        const enumName = `BPKFontStyle${_.upperFirst(fontProps.key)}`;
        
        return {
            name: swiftUIName(fontProps.key),
            size: Number.parseInt(fontProps.sizeProp[0].value, 10),
            weight: convertFontWeight(WEIGHT_MAP_SWIFTUI, fontProps.weightProp[0].value),
            type: 'font',
            lineHeight: lineHeightFor(fontProps.lineHeightProp[0]),
            letterSpacing: letterSpacingFor(fontProps.letterSpacingProp[0]),
            textStyle: textStyleValueForName(enumName)
        };
    })

module.exports = {
    fontTokens: {
        uikit: uikitFonts,
        swiftui: swiftuiFonts
    }
}
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2026 Skyscanner Ltd
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

const assert = require('node:assert/strict');
const test = require('node:test');
const { properties } = require('@skyscanner/bpk-foundations-ios/tokens/base.ios.json');
const { fontTokens } = require('./fonts');

const typographyStyles = [
    { key: 'textHeading1', swiftui: 'heading1', letterSpacing: -1.2 },
    { key: 'textHeading2', swiftui: 'heading2', letterSpacing: -1 },
    { key: 'textHeading3', swiftui: 'heading3', letterSpacing: -0.6 },
    { key: 'textHeading4', swiftui: 'heading4', letterSpacing: -0.6 },
    { key: 'textHeading5', swiftui: 'heading5', letterSpacing: -0.6 },
    { key: 'textHero5', swiftui: 'hero5', letterSpacing: -1.2 },
];

const replacingToken = (name, value) => properties.map(prop => prop.name === name ? { ...prop, value } : prop);

for (const [platform, generate] of Object.entries(fontTokens)) {
    test(`${platform}: uses the finalized typography with the current Foundations tokens`, () => {
        const fonts = generate(properties);
        for (const style of typographyStyles) {
            const font = fonts.find(font => font.name === (platform === 'uikit' ? style.key : style.swiftui));
            assert.equal(font.weight, platform === 'uikit' ? 'UIFontWeightBlack' : 'black');
            assert.equal(font.letterSpacing.value, style.letterSpacing);
        }
    });

    for (const style of typographyStyles) {
        test(`${platform}: rejects an upstream spacing update for ${style.key}`, () => {
            const updated = replacingToken(`${style.key}LetterSpacing`, String(style.letterSpacing / 100));
            assert.throws(() => generate(updated), new RegExp(`Foundations typography changed for ${style.key}`));
        });

        if (style.key !== 'textHero5') {
            test(`${platform}: rejects an upstream weight update for ${style.key}`, () => {
                const updated = replacingToken(`${style.key}FontWeight`, '900');
                assert.throws(() => generate(updated), new RegExp(`Foundations typography changed for ${style.key}`));
            });
        }
    }

    test(`${platform}: rejects a missing overridden spacing token`, () => {
        const updated = properties.filter(prop => prop.name !== 'textHero5LetterSpacing');
        assert.throws(() => generate(updated), /Foundations typography changed for textHero5/);
    });

    test(`${platform}: preserves upstream updates for styles without overrides`, () => {
        const updated = replacingToken('textHero6FontWeight', '700').map(prop =>
            prop.name === 'textHero6LetterSpacing' ? { ...prop, value: '-0.01' } : prop);
        const font = generate(updated).find(font => font.name === (platform === 'uikit' ? 'textHero6' : 'hero6'));
        assert.equal(font.weight, platform === 'uikit' ? 'UIFontWeightBold' : 'semibold');
        assert.equal(font.letterSpacing.value, -1);
    });
}

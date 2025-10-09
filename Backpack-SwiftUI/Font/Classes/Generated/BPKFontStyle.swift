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
 
import UIKit
import SwiftUI

public struct BPKFontStyle {
    public let font: Font
    public let fontFixed: Font
    public let letterSpacing: CGFloat
    public let lineHeight: CGFloat
}

public extension BPKFontStyle {
    
    /// Represents font size 16 with weight semibold.
    static let baseLarken = BPKFontStyle(
        font: .semibold(size: 16, textStyle: .body),
        fontFixed: .semiboldFixed(size: 16),
        letterSpacing: 0,
        lineHeight: 20
    )

    /// Represents font size 16 with weight regular.
    static let bodyDefault = BPKFontStyle(
        font: .regular(size: 16, textStyle: .body),
        fontFixed: .regularFixed(size: 16),
        letterSpacing: 0,
        lineHeight: 24
    )

    /// Represents font size 20 with weight regular.
    static let bodyLongform = BPKFontStyle(
        font: .regular(size: 20, textStyle: .body),
        fontFixed: .regularFixed(size: 20),
        letterSpacing: 0,
        lineHeight: 28
    )

    /// Represents font size 12 with weight regular.
    static let caption = BPKFontStyle(
        font: .regular(size: 12, textStyle: .caption),
        fontFixed: .regularFixed(size: 12),
        letterSpacing: 0,
        lineHeight: 16
    )

    /// Represents font size 32 with weight black.
    static let display7 = BPKFontStyle(
        font: .black(size: 32, textStyle: .largeTitle),
        fontFixed: .blackFixed(size: 32),
        letterSpacing: -1.6,
        lineHeight: 28
    )

    /// Represents font size 16 with weight regular.
    static let editorial4 = BPKFontStyle(
        font: .regular(size: 16, textStyle: .body),
        fontFixed: .regularFixed(size: 16),
        letterSpacing: 0,
        lineHeight: 16
    )

    /// Represents font size 14 with weight regular.
    static let editorial5 = BPKFontStyle(
        font: .regular(size: 14, textStyle: .body),
        fontFixed: .regularFixed(size: 14),
        letterSpacing: 0,
        lineHeight: 16
    )

    /// Represents font size 12 with weight regular.
    static let editorial6 = BPKFontStyle(
        font: .regular(size: 12, textStyle: .body),
        fontFixed: .regularFixed(size: 12),
        letterSpacing: 0,
        lineHeight: 16
    )

    /// Represents font size 14 with weight regular.
    static let footnote = BPKFontStyle(
        font: .regular(size: 14, textStyle: .footnote),
        fontFixed: .regularFixed(size: 14),
        letterSpacing: 0,
        lineHeight: 20
    )

    /// Represents font size 40 with weight semibold.
    static let heading1 = BPKFontStyle(
        font: .semibold(size: 40, textStyle: .title),
        fontFixed: .semiboldFixed(size: 40),
        letterSpacing: 0,
        lineHeight: 48
    )

    /// Represents font size 32 with weight semibold.
    static let heading2 = BPKFontStyle(
        font: .semibold(size: 32, textStyle: .title2),
        fontFixed: .semiboldFixed(size: 32),
        letterSpacing: 0,
        lineHeight: 40
    )

    /// Represents font size 24 with weight semibold.
    static let heading3 = BPKFontStyle(
        font: .semibold(size: 24, textStyle: .title3),
        fontFixed: .semiboldFixed(size: 24),
        letterSpacing: 0,
        lineHeight: 28
    )

    /// Represents font size 20 with weight semibold.
    static let heading4 = BPKFontStyle(
        font: .semibold(size: 20, textStyle: .title3),
        fontFixed: .semiboldFixed(size: 20),
        letterSpacing: 0,
        lineHeight: 24
    )

    /// Represents font size 16 with weight semibold.
    static let heading5 = BPKFontStyle(
        font: .semibold(size: 16, textStyle: .title3),
        fontFixed: .semiboldFixed(size: 16),
        letterSpacing: 0,
        lineHeight: 20
    )

    /// Represents font size 120 with weight semibold.
    static let hero1 = BPKFontStyle(
        font: .semibold(size: 120, textStyle: .largeTitle),
        fontFixed: .semiboldFixed(size: 120),
        letterSpacing: -2,
        lineHeight: 120
    )

    /// Represents font size 96 with weight semibold.
    static let hero2 = BPKFontStyle(
        font: .semibold(size: 96, textStyle: .largeTitle),
        fontFixed: .semiboldFixed(size: 96),
        letterSpacing: -2,
        lineHeight: 96
    )

    /// Represents font size 76 with weight semibold.
    static let hero3 = BPKFontStyle(
        font: .semibold(size: 76, textStyle: .largeTitle),
        fontFixed: .semiboldFixed(size: 76),
        letterSpacing: -2,
        lineHeight: 84
    )

    /// Represents font size 64 with weight semibold.
    static let hero4 = BPKFontStyle(
        font: .semibold(size: 64, textStyle: .largeTitle),
        fontFixed: .semiboldFixed(size: 64),
        letterSpacing: -2,
        lineHeight: 72
    )

    /// Represents font size 48 with weight black.
    static let hero5 = BPKFontStyle(
        font: .black(size: 48, textStyle: .largeTitle),
        fontFixed: .blackFixed(size: 48),
        letterSpacing: -2,
        lineHeight: 56
    )

    /// Represents font size 40 with weight black.
    static let hero6 = BPKFontStyle(
        font: .black(size: 40, textStyle: .largeTitle),
        fontFixed: .blackFixed(size: 40),
        letterSpacing: -1.2,
        lineHeight: 56
    )

    /// Represents font size 16 with weight semibold.
    static let label1 = BPKFontStyle(
        font: .semibold(size: 16, textStyle: .body),
        fontFixed: .semiboldFixed(size: 16),
        letterSpacing: 0,
        lineHeight: 24
    )

    /// Represents font size 14 with weight semibold.
    static let label2 = BPKFontStyle(
        font: .semibold(size: 14, textStyle: .body),
        fontFixed: .semiboldFixed(size: 14),
        letterSpacing: 0,
        lineHeight: 20
    )

    /// Represents font size 12 with weight semibold.
    static let label3 = BPKFontStyle(
        font: .semibold(size: 12, textStyle: .body),
        fontFixed: .semiboldFixed(size: 12),
        letterSpacing: 0,
        lineHeight: 16
    )

    /// Represents font size 14 with weight semibold.
    static let smLarken = BPKFontStyle(
        font: .semibold(size: 14, textStyle: .footnote),
        fontFixed: .semiboldFixed(size: 14),
        letterSpacing: 0,
        lineHeight: 20
    )

    /// Represents font size 24 with weight regular.
    static let subheading = BPKFontStyle(
        font: .regular(size: 24, textStyle: .subheadline),
        fontFixed: .regularFixed(size: 24),
        letterSpacing: 0,
        lineHeight: 32
    )

    /// Represents font size 12 with weight semibold.
    static let xsLarken = BPKFontStyle(
        font: .semibold(size: 12, textStyle: .caption),
        fontFixed: .semiboldFixed(size: 12),
        letterSpacing: 0,
        lineHeight: 16
    )

}

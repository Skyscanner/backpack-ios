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

/// Backpack Static Colors
public extension BPKColor {
    private init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(value: UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }

    /// The `skyBlueShade03` color from the Backpack palette - rgb(2, 18, 44)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueShade03 = BPKColor(red:0.008, green:0.071, blue:0.173, alpha:1)

    /// The `primaryGradientLight` color from the Backpack palette - rgb(7, 112, 227)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let primaryGradientLight = BPKColor(red:0.027, green:0.439, blue:0.890, alpha:1)

    /// The `erfoud` color from the Backpack palette - rgb(255, 181, 77)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let erfoud = BPKColor(red:1.000, green:0.710, blue:0.302, alpha:1)

    /// The `valensole` color from the Backpack palette - rgb(165, 155, 200)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let valensole = BPKColor(red:0.647, green:0.608, blue:0.784, alpha:1)

    /// The `monteverde` color from the Backpack palette - rgb(0, 166, 152)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let monteverde = BPKColor(red:0.000, green:0.651, blue:0.596, alpha:1)

    /// The `skyGrayTint01` color from the Backpack palette - rgb(68, 69, 96)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint01 = BPKColor(red:0.267, green:0.271, blue:0.376, alpha:1)

    /// The `black` color from the Backpack palette - rgb(0, 0, 0)
    
    static let black = BPKColor(red:0.000, green:0.000, blue:0.000, alpha:1)

    /// The `skyGrayTint02` color from the Backpack palette - rgb(104, 105, 127)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint02 = BPKColor(red:0.408, green:0.412, blue:0.498, alpha:1)

    /// The `sagano` color from the Backpack palette - rgb(208, 238, 236)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let sagano = BPKColor(red:0.816, green:0.933, blue:0.925, alpha:1)

    /// The `skyGrayTint03` color from the Backpack palette - rgb(143, 144, 160)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint03 = BPKColor(red:0.561, green:0.565, blue:0.627, alpha:1)

    /// The `skyGrayTint04` color from the Backpack palette - rgb(178, 178, 191)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint04 = BPKColor(red:0.698, green:0.698, blue:0.749, alpha:1)

    /// The `harbour` color from the Backpack palette - rgb(246, 221, 225)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let harbour = BPKColor(red:0.965, green:0.867, blue:0.882, alpha:1)

    /// The `skyGrayTint05` color from the Backpack palette - rgb(205, 205, 215)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint05 = BPKColor(red:0.804, green:0.804, blue:0.843, alpha:1)

    /// The `skyGrayTint06` color from the Backpack palette - rgb(221, 221, 229)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint06 = BPKColor(red:0.867, green:0.867, blue:0.898, alpha:1)

    /// The `blackTint01` color from the Backpack palette - rgb(29, 27, 32)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint01 = BPKColor(red:0.114, green:0.106, blue:0.125, alpha:1)

    /// The `skyGrayTint07` color from the Backpack palette - rgb(241, 242, 248)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint07 = BPKColor(red:0.945, green:0.949, blue:0.973, alpha:1)

    /// The `blackTint02` color from the Backpack palette - rgb(44, 44, 46)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint02 = BPKColor(red:0.173, green:0.173, blue:0.180, alpha:1)

    /// The `abisko` color from the Backpack palette - rgb(90, 72, 155)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let abisko = BPKColor(red:0.353, green:0.282, blue:0.608, alpha:1)

    /// The `blackTint03` color from the Backpack palette - rgb(58, 58, 60)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint03 = BPKColor(red:0.227, green:0.227, blue:0.235, alpha:1)

    /// The `blackTint04` color from the Backpack palette - rgb(72, 72, 74)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint04 = BPKColor(red:0.282, green:0.282, blue:0.290, alpha:1)

    /// The `white` color from the Backpack palette - rgb(255, 255, 255)
    
    static let white = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)

    /// The `blackTint05` color from the Backpack palette - rgb(99, 99, 102)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint05 = BPKColor(red:0.388, green:0.388, blue:0.400, alpha:1)

    /// The `blackTint06` color from the Backpack palette - rgb(142, 142, 147)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint06 = BPKColor(red:0.557, green:0.557, blue:0.576, alpha:1)

    /// The `panjin` color from the Backpack palette - rgb(209, 67, 91)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let panjin = BPKColor(red:0.820, green:0.263, blue:0.357, alpha:1)

    /// The `kolkata` color from the Backpack palette - rgb(255, 148, 0)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let kolkata = BPKColor(red:1.000, green:0.580, blue:0.000, alpha:1)

    /// The `glencoe` color from the Backpack palette - rgb(115, 206, 198)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let glencoe = BPKColor(red:0.451, green:0.808, blue:0.776, alpha:1)

    /// The `tochigi` color from the Backpack palette - rgb(225, 221, 236)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let tochigi = BPKColor(red:0.882, green:0.867, blue:0.925, alpha:1)

    /// The `petra` color from the Backpack palette - rgb(255, 171, 149)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let petra = BPKColor(red:1.000, green:0.671, blue:0.584, alpha:1)

    /// The `skyBlue` color from the Backpack palette - rgb(7, 112, 227)
    
    static let skyBlue = BPKColor(red:0.027, green:0.439, blue:0.890, alpha:1)

    /// The `bagan` color from the Backpack palette - rgb(255, 235, 208)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let bagan = BPKColor(red:1.000, green:0.922, blue:0.816, alpha:1)

    /// The `hillier` color from the Backpack palette - rgb(225, 139, 150)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let hillier = BPKColor(red:0.882, green:0.545, blue:0.588, alpha:1)

    /// The `skyBlueTint01` color from the Backpack palette - rgb(109, 159, 235)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueTint01 = BPKColor(red:0.427, green:0.624, blue:0.922, alpha:1)

    /// The `skyBlueTint02` color from the Backpack palette - rgb(157, 192, 242)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueTint02 = BPKColor(red:0.616, green:0.753, blue:0.949, alpha:1)

    /// The `bunol` color from the Backpack palette - rgb(255, 123, 89)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let bunol = BPKColor(red:1.000, green:0.482, blue:0.349, alpha:1)

    /// The `skyBlueTint03` color from the Backpack palette - rgb(205, 223, 248)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueTint03 = BPKColor(red:0.804, green:0.875, blue:0.973, alpha:1)

    /// The `skyGray` color from the Backpack palette - rgb(17, 18, 54)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGray = BPKColor(red:0.067, green:0.071, blue:0.212, alpha:1)

    /// The `nara` color from the Backpack palette - rgb(255, 231, 224)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let nara = BPKColor(red:1.000, green:0.906, blue:0.878, alpha:1)

    /// The `skyBlueShade01` color from the Backpack palette - rgb(8, 78, 178)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueShade01 = BPKColor(red:0.031, green:0.306, blue:0.698, alpha:1)

    /// The `skyBlueShade02` color from the Backpack palette - rgb(4, 39, 89)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueShade02 = BPKColor(red:0.016, green:0.153, blue:0.349, alpha:1)

    /// The `systemGreen` color from the Backpack palette - rgb(0, 166, 152)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let systemGreen = BPKColor(red:0.000, green:0.651, blue:0.596, alpha:1)

    /// The `systemRed` color from the Backpack palette - rgb(209, 67, 91)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let systemRed = BPKColor(red:0.820, green:0.263, blue:0.357, alpha:1)

    /// The `shadowSmColor` color from the Backpack palette - rgb(17, 18, 54)
    
    static let shadowSmColor = BPKColor(red:0.067, green:0.071, blue:0.212, alpha:1)

    /// The `shadowLgColor` color from the Backpack palette - rgb(17, 18, 54)
    
    static let shadowLgColor = BPKColor(red:0.067, green:0.071, blue:0.212, alpha:1)

    /// The `touchableOverlayColor` color from the Backpack palette - rgb(17, 18, 54)
    
    static let touchableOverlayColor = BPKColor(red:0.067, green:0.071, blue:0.212, alpha:1)
}

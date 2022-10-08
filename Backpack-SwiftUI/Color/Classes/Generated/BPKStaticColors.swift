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

    /// The `skyBlueShade03` color from the Backpack palette - rgb(5, 32, 60)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueShade03 = BPKColor(red:0.020, green:0.125, blue:0.235, alpha:1)

    /// The `primaryGradientLight` color from the Backpack palette - rgb(0, 98, 227)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let primaryGradientLight = BPKColor(red:0.000, green:0.384, blue:0.890, alpha:1)

    /// The `erfoud` color from the Backpack palette - rgb(254, 235, 135)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let erfoud = BPKColor(red:0.996, green:0.922, blue:0.529, alpha:1)

    /// The `valensole` color from the Backpack palette - rgb(224, 227, 229)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let valensole = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)

    /// The `monteverde` color from the Backpack palette - rgb(12, 131, 138)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let monteverde = BPKColor(red:0.047, green:0.514, blue:0.541, alpha:1)

    /// The `skyGrayTint01` color from the Backpack palette - rgb(84, 88, 96)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint01 = BPKColor(red:0.329, green:0.345, blue:0.376, alpha:1)

    /// The `black` color from the Backpack palette - rgb(1, 9, 19)
    
    static let black = BPKColor(red:0.004, green:0.035, blue:0.075, alpha:1)

    /// The `skyGrayTint02` color from the Backpack palette - rgb(84, 88, 96)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint02 = BPKColor(red:0.329, green:0.345, blue:0.376, alpha:1)

    /// The `sagano` color from the Backpack palette - rgb(212, 255, 242)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let sagano = BPKColor(red:0.831, green:1.000, blue:0.949, alpha:1)

    /// The `skyGrayTint03` color from the Backpack palette - rgb(84, 88, 96)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint03 = BPKColor(red:0.329, green:0.345, blue:0.376, alpha:1)

    /// The `skyGrayTint04` color from the Backpack palette - rgb(194, 201, 205)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint04 = BPKColor(red:0.761, green:0.788, blue:0.804, alpha:1)

    /// The `harbour` color from the Backpack palette - rgb(255, 233, 249)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let harbour = BPKColor(red:1.000, green:0.914, blue:0.976, alpha:1)

    /// The `skyGrayTint05` color from the Backpack palette - rgb(194, 201, 205)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint05 = BPKColor(red:0.761, green:0.788, blue:0.804, alpha:1)

    /// The `skyGrayTint06` color from the Backpack palette - rgb(224, 227, 229)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint06 = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)

    /// The `blackTint01` color from the Backpack palette - rgb(19, 29, 43)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint01 = BPKColor(red:0.075, green:0.114, blue:0.169, alpha:1)

    /// The `skyGrayTint07` color from the Backpack palette - rgb(239, 241, 242)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGrayTint07 = BPKColor(red:0.937, green:0.945, blue:0.949, alpha:1)

    /// The `blackTint02` color from the Backpack palette - rgb(19, 29, 43)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint02 = BPKColor(red:0.075, green:0.114, blue:0.169, alpha:1)

    /// The `abisko` color from the Backpack palette - rgb(5, 32, 60)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let abisko = BPKColor(red:0.020, green:0.125, blue:0.235, alpha:1)

    /// The `blackTint03` color from the Backpack palette - rgb(36, 51, 70)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint03 = BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1)

    /// The `blackTint04` color from the Backpack palette - rgb(68, 80, 95)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint04 = BPKColor(red:0.267, green:0.314, blue:0.373, alpha:1)

    /// The `white` color from the Backpack palette - rgb(255, 255, 255)
    
    static let white = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)

    /// The `blackTint05` color from the Backpack palette - rgb(68, 80, 95)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint05 = BPKColor(red:0.267, green:0.314, blue:0.373, alpha:1)

    /// The `blackTint06` color from the Backpack palette - rgb(189, 196, 203)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let blackTint06 = BPKColor(red:0.741, green:0.769, blue:0.796, alpha:1)

    /// The `panjin` color from the Backpack palette - rgb(231, 8, 102)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let panjin = BPKColor(red:0.906, green:0.031, blue:0.400, alpha:1)

    /// The `kolkata` color from the Backpack palette - rgb(245, 93, 66)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let kolkata = BPKColor(red:0.961, green:0.365, blue:0.259, alpha:1)

    /// The `glencoe` color from the Backpack palette - rgb(98, 241, 198)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let glencoe = BPKColor(red:0.384, green:0.945, blue:0.776, alpha:1)

    /// The `tochigi` color from the Backpack palette - rgb(239, 241, 242)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let tochigi = BPKColor(red:0.937, green:0.945, blue:0.949, alpha:1)

    /// The `petra` color from the Backpack palette - rgb(254, 235, 135)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let petra = BPKColor(red:0.996, green:0.922, blue:0.529, alpha:1)

    /// The `skyBlue` color from the Backpack palette - rgb(0, 98, 227)
    
    static let skyBlue = BPKColor(red:0.000, green:0.384, blue:0.890, alpha:1)

    /// The `bagan` color from the Backpack palette - rgb(255, 247, 207)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let bagan = BPKColor(red:1.000, green:0.969, blue:0.812, alpha:1)

    /// The `hillier` color from the Backpack palette - rgb(255, 100, 156)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let hillier = BPKColor(red:1.000, green:0.392, blue:0.612, alpha:1)

    /// The `skyBlueTint01` color from the Backpack palette - rgb(132, 233, 255)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueTint01 = BPKColor(red:0.518, green:0.914, blue:1.000, alpha:1)

    /// The `skyBlueTint02` color from the Backpack palette - rgb(224, 227, 229)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueTint02 = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)

    /// The `bunol` color from the Backpack palette - rgb(245, 93, 66)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let bunol = BPKColor(red:0.961, green:0.365, blue:0.259, alpha:1)

    /// The `skyBlueTint03` color from the Backpack palette - rgb(224, 227, 229)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueTint03 = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)

    /// The `skyGray` color from the Backpack palette - rgb(22, 22, 22)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyGray = BPKColor(red:0.086, green:0.086, blue:0.086, alpha:1)

    /// The `nara` color from the Backpack palette - rgb(255, 247, 207)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let nara = BPKColor(red:1.000, green:0.969, blue:0.812, alpha:1)

    /// The `skyBlueShade01` color from the Backpack palette - rgb(0, 98, 227)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueShade01 = BPKColor(red:0.000, green:0.384, blue:0.890, alpha:1)

    /// The `skyBlueShade02` color from the Backpack palette - rgb(5, 32, 60)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let skyBlueShade02 = BPKColor(red:0.020, green:0.125, blue:0.235, alpha:1)

    /// The `systemGreen` color from the Backpack palette - rgb(12, 131, 138)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let systemGreen = BPKColor(red:0.047, green:0.514, blue:0.541, alpha:1)

    /// The `systemRed` color from the Backpack palette - rgb(231, 8, 102)
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let systemRed = BPKColor(red:0.906, green:0.031, blue:0.400, alpha:1)

    /// The `shadowSmColor` color from the Backpack palette - rgb(22, 22, 22)
    
    static let shadowSmColor = BPKColor(red:0.086, green:0.086, blue:0.086, alpha:1)

    /// The `shadowLgColor` color from the Backpack palette - rgb(22, 22, 22)
    
    static let shadowLgColor = BPKColor(red:0.086, green:0.086, blue:0.086, alpha:1)

    /// The `touchableOverlayColor` color from the Backpack palette - rgb(22, 22, 22)
    
    static let touchableOverlayColor = BPKColor(red:0.086, green:0.086, blue:0.086, alpha:1)
}

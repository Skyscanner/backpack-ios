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

import XCTest
import SwiftUI
@testable import Backpack_SwiftUI

class ButtonColorProviderTests: XCTestCase {
    func testPrimaryStyleReturnsPrimarySetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .primary)
        XCTAssertTrue(colorSet is PrimaryBPKButtonColorSet)
    }
    
    func testSecondaryStyleReturnsSecondarySetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .secondary)
        XCTAssertTrue(colorSet is SecondaryBPKButtonColorSet)
    }
    
    func testSecondaryOnDarkStyleReturnsSecondaryOnDarkSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .secondaryOnDark)
        XCTAssertTrue(colorSet is SecondaryOnDarkBPKButtonColorSet)
    }
    
    func testDestructiveStyleReturnsDestructiveSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .destructive)
        XCTAssertTrue(colorSet is DestructiveBPKButtonColorSet)
    }
    
    func testFeaturedStyleReturnsFeaturedSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .featured)
        XCTAssertTrue(colorSet is FeaturedBPKButtonColorSet)
    }
    
    func testLinkStyleReturnsLinkSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .link)
        XCTAssertTrue(colorSet is LinkBPKButtonColorSet)
    }
    
    func testLinkOnDarkStyleReturnsLinkOnDarkSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .linkOnDark)
        XCTAssertTrue(colorSet is LinkOnDarkBPKButtonColorSet)
    }
    
    func testPrimaryOnDarkStyleReturnsPrimaryOnDarkSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .primaryOnDark)
        XCTAssertTrue(colorSet is PrimaryOnDarkBPKButtonColorSet)
    }
    
    func testPrimaryOnLightStyleReturnsPrimaryOnLightSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .primaryOnLight)
        XCTAssertTrue(colorSet is PrimaryOnLightBPKButtonColorSet)
    }
    
    func testSecondaryOnContrastReturnsSecondaryOnContrastColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .secondaryOnContrast)
        XCTAssertTrue(colorSet is SecondaryOnContrastBPKButtonColorSet)
    }

    func test_whenSecondaryButtonIsPressedOrLoading_thenPreservesExistingIOSColors() {
        // Given
        let colorSet = DefaultButtonColorSetFactory().colorSet(forStyle: .secondary)

        // When
        for colors in [colorSet.highlighted, colorSet.loading] {
            // Then
            assertColor(colors.background,
                        light: UIColor(red: 180/255, green: 215/255, blue: 255/255, alpha: 1),
                        dark: UIColor(red: 68/255, green: 80/255, blue: 95/255, alpha: 1))
        }
    }

    func test_whenSecondaryOnContrastButtonIsPressedOrLoading_thenPreservesExistingIOSColors() {
        // Given
        let colorSet = DefaultButtonColorSetFactory().colorSet(forStyle: .secondaryOnContrast)

        // When
        for colors in [colorSet.highlighted, colorSet.loading] {
            // Then
            assertColor(colors.background,
                        light: UIColor(red: 180/255, green: 215/255, blue: 255/255, alpha: 1),
                        dark: UIColor(red: 60/255, green: 80/255, blue: 95/255, alpha: 1))
        }
    }

    func test_whenSecondaryButtonColorsAreResolved_thenPreservesExistingForegroundColors() {
        // Given
        let factory = DefaultButtonColorSetFactory()

        // When
        for style in [BPKButton.Style.secondary, .secondaryOnContrast] {
            let colorSet = factory.colorSet(forStyle: style)
            for colors in [colorSet.regular, colorSet.highlighted, colorSet.loading] {
                // Then
                assertColor(colors.foreground,
                            light: UIColor(red: 2/255, green: 77/255, blue: 175/255, alpha: 1),
                            dark: UIColor(red: 1, green: 1, blue: 1, alpha: 1))
            }
        }
    }

    func test_whenSecondaryOnContrastButtonIsEnabled_thenPreservesExistingBackgroundColors() {
        // Given
        let colorSet = DefaultButtonColorSetFactory().colorSet(forStyle: .secondaryOnContrast)

        // When
        let background = colorSet.regular.background

        // Then
        assertColor(background,
                    light: UIColor(red: 207/255, green: 228/255, blue: 255/255, alpha: 1),
                    dark: UIColor(red: 36/255, green: 51/255, blue: 70/255, alpha: 1))
    }

    private func assertColor(_ color: BPKColor, light: UIColor, dark: UIColor,
                             file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(color.value.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light)),
                       light, file: file, line: line)
        XCTAssertEqual(color.value.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark)),
                       dark, file: file, line: line)
    }
    
}

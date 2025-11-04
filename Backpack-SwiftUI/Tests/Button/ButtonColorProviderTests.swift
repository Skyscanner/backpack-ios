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
        let colorSet = sut.colorSet(forStyle: .primary, config: nil)
        XCTAssertTrue(colorSet is PrimaryBPKButtonColorSet)
    }
    
    func testSecondaryStyleReturnsSecondarySetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .secondary, config: nil)
        XCTAssertTrue(colorSet is SecondaryBPKButtonColorSet)
    }
    
    func testSecondaryOnDarkStyleReturnsSecondaryOnDarkSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .secondaryOnDark, config: nil)
        XCTAssertTrue(colorSet is SecondaryOnDarkBPKButtonColorSet)
    }
    
    func testDestructiveStyleReturnsDestructiveSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .destructive, config: nil)
        XCTAssertTrue(colorSet is DestructiveBPKButtonColorSet)
    }
    
    func testFeaturedStyleReturnsFeaturedSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .featured, config: nil)
        XCTAssertTrue(colorSet is FeaturedBPKButtonColorSet)
    }
    
    func testLinkStyleReturnsLinkSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .link, config: nil)
        XCTAssertTrue(colorSet is LinkBPKButtonColorSet)
    }
    
    func testLinkOnDarkStyleReturnsLinkOnDarkSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .linkOnDark, config: nil)
        XCTAssertTrue(colorSet is LinkOnDarkBPKButtonColorSet)
    }
    
    func testPrimaryOnDarkStyleReturnsPrimaryOnDarkSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .primaryOnDark, config: nil)
        XCTAssertTrue(colorSet is PrimaryOnDarkBPKButtonColorSet)
    }
    
    func testPrimaryOnLightStyleReturnsPrimaryOnLightSetColors() {
        let sut = DefaultButtonColorSetFactory()
        let colorSet = sut.colorSet(forStyle: .primaryOnLight, config: nil)
        XCTAssertTrue(colorSet is PrimaryOnLightBPKButtonColorSet)
    }
    
}

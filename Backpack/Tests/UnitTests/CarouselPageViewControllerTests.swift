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
@testable import Backpack

final class CarouselPageViewControllerTests: XCTestCase {
    
    private let pageOne = UIViewController()
    private let pageTwo = UIViewController()
    private let pageThree = UIViewController()
    private let pageFour = UIViewController()
    
    private var pages = [UIViewController]()
        
    override func tearDown() {
        pages = []
        super.tearDown()
    }
    
    // MARK: viewControllerAfter
    func testGivenFourPages_whenLastDisplayedPageTwo_thenViewControllerAfterIsPageThree() {
        // Given
        pages = [pageOne, pageTwo, pageThree, pageFour]
        
        // When
        let sut = viewControllerAfter(lastDisplayed: pageTwo, pages: pages)
        
        // Then
        XCTAssertEqual(sut, pageThree)
    }
    
    func testGivenOnePage_whenLastDisplayedPageOne_thenViewControllerAfterIsNil() {
        // Given
        pages = [pageOne]
        
        // When
        let sut = viewControllerAfter(lastDisplayed: pageOne, pages: pages)
        
        // Then
        XCTAssertEqual(sut, nil)
    }
    
    func testGivenFourPages_whenLastDisplayedPageFour_thenViewControllerAfterIsPageOne() {
        // Given
        pages = [pageOne, pageTwo, pageThree, pageFour]
        
        // When
        let sut = viewControllerAfter(lastDisplayed: pageFour, pages: pages)
        
        // Then
        XCTAssertEqual(sut, pageOne)
    }
    
    // MARK: viewControllerBefore
    func testGivenFourPages_whenLastDisplayedPageTwo_thenViewControllerBeforeIsPageOne() {
        // Given
        pages = [pageOne, pageTwo, pageThree, pageFour]
        
        // When
        let sut = viewControllerBefore(lastDisplayed: pageTwo, pages: pages)
        
        // Then
        XCTAssertEqual(sut, pageOne)
    }
    
    func testGivenOnePage_whenLastDisplayedPageOne_thenViewControllerBeforeIsNil() {
        // Given
        pages = [pageOne]
        
        // When
        let sut = viewControllerBefore(lastDisplayed: pageOne, pages: pages)
        
        // Then
        XCTAssertEqual(sut, nil)
    }
    
    func testGivenFourPages_whenLastDisplayedPageOne_thenViewControllerBeforeIsPageFour() {
        // Given
        pages = [pageOne, pageTwo, pageThree, pageFour]
        
        // When
        let sut = viewControllerBefore(lastDisplayed: pageOne, pages: pages)
        
        // Then
        XCTAssertEqual(sut, pageFour)
    }
}

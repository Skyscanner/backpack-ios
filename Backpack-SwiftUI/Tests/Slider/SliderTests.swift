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

class SliderTests: XCTestCase {
    func testRegularSlider() {
        assertSnapshot(
            BPKSlider(
                value: .constant(0.5),
                sliderBounds: 0...1
            )
            .frame(width: 200)
            .padding()
        )
    }
    
    func testRangeSlider() {
        assertSnapshot(
            BPKRangeSlider(
                selectedRange: .constant(0.5...0.7),
                sliderBounds: 0...1
            )
            .frame(width: 200, height: .zero)
            .padding()
        )
    }

    func testCanCalculateNewValueFromDrag() {
        let newValue = BPKSliderHelpers.calculateNewValueFromDrag(
            xLocation: 100,
            sliderWidth: 200,
            thumbSize: 20,
            sliderBounds: -20...50,
            step: 1,
            layoutDirection: .leftToRight
        )
        XCTAssertEqual(newValue, 47.0)
    }
    
    func testCanCalculateNewValueFromDragOnRTL() {
        let newValue = BPKSliderHelpers.calculateNewValueFromDrag(
            xLocation: 100,
            sliderWidth: 200,
            thumbSize: 20,
            sliderBounds: -20...50,
            step: 1,
            layoutDirection: .rightToLeft
        )
        XCTAssertEqual(newValue, -17.0)
    }

    func testCanCalculateNewValueFromDrawWithStep() {
        let newValue = BPKSliderHelpers.calculateNewValueFromDrag(
            xLocation: 100,
            sliderWidth: 200,
            thumbSize: 20,
            sliderBounds: -20...50,
            step: 5,
            layoutDirection: .leftToRight
        )
        XCTAssertEqual(newValue, 45.0)
    }

    func testCanCalculatePercentageOfValue() {
        let percentage = BPKSliderHelpers.percentageOfValue(value: 12.5, sliderBounds: -25...50)
        XCTAssertEqual(percentage, 0.5)
    }

    func testCanCalculateValueForPercentage() {
        let value = BPKSliderHelpers.valueForPercentage(0.5, sliderBounds: -25...50)
        XCTAssertEqual(value, 12.5)
    }
}

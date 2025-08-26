/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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

class PriceRangeTests: XCTestCase {
    
    func test_default_marker_high() {
        assertSnapshot(
            createDefaultPriceRangeExample(text: "£850", percentage: 85)
                .frame(width: 240)
        )
    }
    
    func test_default_marker_low() {
        assertSnapshot(
            createDefaultPriceRangeExample(text: "£150", percentage: 15)
                .frame(width: 240)
        )
    }
    
    func test_default_marker_middle() {
        assertSnapshot(
            createDefaultPriceRangeExample(text: "£500", percentage: 50)
                .frame(width: 240)
        )
    }
    
    func test_collapsed_marker_high() {
        assertSnapshot(
            createCollapsedPriceRangeExample(percentage: 90)
                .frame(width: 140)
        )
    }
    
    func test_collapsed_marker_low() {
        assertSnapshot(
            createCollapsedPriceRangeExample(percentage: 10)
                .frame(width: 140)
        )
    }
    
    func test_collapsed_marker_middle() {
        assertSnapshot(
            createCollapsedPriceRangeExample(percentage: 50)
                .frame(width: 140)
        )
    }
    
    private func createDefaultPriceRangeExample(text: String, percentage: Double) -> some View {
        BPKPriceRange(configuration: .default(.init(
            marker: .init(text: text, percentage: percentage),
            segments: .init(
                lower: .init(text: "£200", percentage: 20),
                upper: .init(text: "£800", percentage: 80)
            )
        )))
    }
    
    private func createCollapsedPriceRangeExample(percentage: Double) -> some View {
        BPKPriceRange(configuration: .collapsed(.init(
            markerPercentage: percentage,
            segments: .init(lower: 20, upper: 80)
        )))
    }
}

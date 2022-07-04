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

class BPKSpinnerTests: XCTestCase {

    private func testView(icon: BPKIcon? = nil) -> some View {
        ZStack {
            Color(.skyGrayTint06.darkVariant(.black))
            VStack {
                HStack {
                    BPKSpinner(.sm, style: .textPrimary)
                    BPKSpinner(.lg, style: .textPrimary)
                    BPKSpinner(.xl, style: .textPrimary)
                }
                
                HStack {
                    BPKSpinner(.sm, style: .disabled)
                    BPKSpinner(.lg, style: .disabled)
                    BPKSpinner(.xl, style: .disabled)
                }
                
                HStack {
                    BPKSpinner(.sm, style: .onDarkSurface)
                    BPKSpinner(.lg, style: .onDarkSurface)
                    BPKSpinner(.xl, style: .onDarkSurface)
                }
            }
            .padding()
        }
    }
    
    func test_allSpinnerStyles() {
        // Then
        assertSnapshot(testView())
    }
}

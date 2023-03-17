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
import SnapshotTesting
@testable import Backpack_SwiftUI

class BPKOverlayTests: XCTestCase {
    func backgroundView(_ overlay: BPKOverlayType) -> some View {
        Color(.white)
            .frame(width: 100, height: 100)
            .bpkOverlay(overlay)
            .cornerRadius(20)
    }
    
    func test_solidOverlay() {
        // Given
        let view = VStack {
            backgroundView(.solid(.low))
            backgroundView(.solid(.medium))
            backgroundView(.solid(.high))
        }
        
        // Then
        assertSnapshot(view)
    }
    
    func test_linearLeadingOverlay() {
        // Given
        let view = VStack {
            backgroundView(.linear(.low, .leading))
            backgroundView(.linear(.medium, .leading))
            backgroundView(.linear(.high, .leading))
        }
        
        // Then
        assertSnapshot(view)
    }
    
    func test_linearTrailingOverlay() {
        // Given
        let view = VStack {
            backgroundView(.linear(.low, .trailing))
            backgroundView(.linear(.medium, .trailing))
            backgroundView(.linear(.high, .trailing))
        }
        
        // Then
        assertSnapshot(view)
    }
    
    func test_linearTopOverlay() {
        // Given
        let view = VStack {
            backgroundView(.linear(.low, .top))
            backgroundView(.linear(.medium, .top))
            backgroundView(.linear(.high, .top))
        }
        
        // Then
        assertSnapshot(view)
    }
    
    func test_linearBottomOverlay() {
        // Given
        let view = VStack {
            backgroundView(.linear(.low, .bottom))
            backgroundView(.linear(.medium, .bottom))
            backgroundView(.linear(.high, .bottom))
        }
        
        // Then
        assertSnapshot(view)
    }
    
    func test_vignetteOverlay() {
        assertSnapshot(backgroundView(.vignette))
    }
}

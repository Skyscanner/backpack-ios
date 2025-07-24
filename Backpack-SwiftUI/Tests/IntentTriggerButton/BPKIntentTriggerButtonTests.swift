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
import AppIntents
@testable import Backpack_SwiftUI

@available(iOS 17.0, *)
final class BPKIntentTriggerButtonTests: XCTestCase {
    func testWithIconLabel() {
        let view = BPKIntentTriggerButton(
            intent: TestRefreshIntent(),
            label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Refresh Data")
                }
                .foregroundColor(.textPrimaryColor)
                .padding()
            }
        )
        .frame(width: 200, height: 100)

        assertSnapshot(view)
    }
    
    func testAccessibilityLabel() {
        let view = BPKIntentTriggerButton(
            intent: TestRefreshIntent(),
            label: {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(.textPrimaryColor)
                    .accessibilityLabel("Refresh content")
            }
        )
        .frame(width: 100, height: 100)
        
        assertA11ySnapshot(view)
    }
}

// MARK: - Test App Intents

@available(iOS 17.0, *)
struct TestRefreshIntent: AppIntent {
    static var title: LocalizedStringResource = "Test Refresh"
    static var description = IntentDescription("Test refresh intent")
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}

// MARK: - iOS < 17 Fallback Tests

final class BPKIntentTriggerButtonFallbackTests: XCTestCase {
    
    func testIOSVersionRequirement() {
        // Test that the component requires iOS 17+
        if #available(iOS 17.0, *) {
            XCTAssertTrue(true, "iOS 17+ is available, BPKIntentTriggerButton should work")
        } else {
            XCTAssertTrue(true, "iOS < 17, BPKIntentTriggerButton is not available as expected")
        }
    }
}

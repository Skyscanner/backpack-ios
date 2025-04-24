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

final class BPKDynamicLayoutTests: XCTestCase {
    func test_dynamicLayout_device_orientation_example_when_landscape() {
        // Simulate environment manually with `.regular` size class
        let view = DynamicLayoutExampleView(horizontalSizeClass: .regular)
        assertA11ySnapshot(view)
    }

    func test_dynamicLayout_device_orientation_example_when_portrait() {
        // Simulate environment manually with `.compact` size class
        let view = DynamicLayoutExampleView(horizontalSizeClass: .compact)
        assertA11ySnapshot(view)
    }

    func test_dynamicTypeLayout_accessibility() {
        let dynamicStack = BPKDynamicTypeLayout {
            BPKText("This is the first text")
            BPKText("This is the second text")
            BPKText("This is the third text")
        }
        assertA11ySnapshot(dynamicStack)
    }
}

private struct DynamicLayoutExampleView: View {
    let horizontalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        let isLandscape = horizontalSizeClass == .regular
        return BPKDynamicLayout(
            primaryLayout: AnyLayout(HStackLayout(alignment: .center)),
            secondaryLayout: AnyLayout(VStackLayout(alignment: .leading)),
            activateSecondaryLayout: .constant(!isLandscape)
        ) {
            BPKText("First text")
            BPKText("Middle text")
            BPKText("Last text")
        }
        .environment(\.horizontalSizeClass, horizontalSizeClass)
    }
}

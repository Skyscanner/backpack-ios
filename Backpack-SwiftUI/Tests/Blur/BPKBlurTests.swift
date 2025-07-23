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
import SnapshotTesting
@testable import Backpack_SwiftUI

final class BPKBlurTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    // MARK: - BPK Blur Modifier Tests
    
    func testBPKBlurModifier_defaultRadius() {
        let hosting = UIHostingController(rootView: testBlurView)
        hosting.view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)

        // Attach to a window
        let window = UIWindow(frame: hosting.view.bounds)
        window.rootViewController = hosting
        window.makeKeyAndVisible()

        // Run the runloop to settle layout and view hierarchy
        RunLoop.main.run(until: Date().addingTimeInterval(0.5))

        // Use CALayer-based rendering
        let imageStrategy = Snapshotting<UIView, UIImage>.image(drawHierarchyInKeyWindow: false)

        assertSnapshot(matching: hosting.view, as: .wait(for: 1.0, on: imageStrategy))
    }
    
    private var testBlurView: some View {
        ZStack {
            Image("dialog_image", bundle: TestsBundle.bundle)
                .resizable()
                .blur(radius: 4)
                .frame(width: 300, height: 300)
        }
    }
}

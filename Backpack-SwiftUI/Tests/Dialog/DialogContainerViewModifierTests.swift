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

import SwiftUI
import UIKit
import XCTest
@testable import Backpack_SwiftUI

/// Regression coverage for DON-3708: with an external keyboard / Full Keyboard Access, background
/// content behind a `bpkSuccessDialogView` (and friends) remained reachable and activatable, because
/// `.isModal` is only honoured by VoiceOver. `.disabled(isPresented)` on the background content is
/// what actually removes it from the focus/interaction system that Full Keyboard Access uses.
///
/// These tests only assert the public, documented `\.isEnabled` environment value, rather than
/// inspecting the UIKit accessibility tree via private APIs: the VoiceOver / Switch Control / Full
/// Keyboard Access behaviour itself was verified manually on-device.
final class DialogContainerViewModifierTests: XCTestCase {
    private struct EnabledProbe: View {
        @Environment(\.isEnabled) private var isEnabled
        @State private var hasRendered = false
        let onRender: (Bool) -> Void

        var body: some View {
            Color.clear
                .frame(width: 1, height: 1)
                .onAppear {
                    // SwiftUI can call `onAppear` more than once across view updates; only report the
                    // first one so the caller's expectation isn't over-fulfilled.
                    guard !hasRendered else { return }
                    hasRendered = true
                    onRender(isEnabled)
                }
        }
    }

    // Keeps the hosting window alive for the duration of a test.
    private var retainedWindows: [UIWindow] = []

    override func tearDown() {
        retainedWindows.removeAll()
        super.tearDown()
    }

    @MainActor
    private func host<V: View>(_ view: V) {
        let hostController = UIHostingController(rootView: view)
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 700))
        window.rootViewController = hostController
        window.makeKeyAndVisible()
        hostController.view.layoutIfNeeded()
        retainedWindows.append(window)
    }

    private func dialogView(isPresented: Bool, onRender: @escaping (Bool) -> Void) -> some View {
        EnabledProbe(onRender: onRender)
            .modifier(DialogContainerViewModifier(
                isPresented: .constant(isPresented),
                dialogContent: { BPKText("Dialog content") },
                onTouchOutside: {}
            ))
    }

    @MainActor
    func test_whenDialogIsNotPresented_thenBackgroundContentIsEnabled() {
        let renderedExpectation = expectation(description: "EnabledProbe rendered")
        var capturedIsEnabled: Bool?
        host(dialogView(isPresented: false) { isEnabled in
            capturedIsEnabled = isEnabled
            renderedExpectation.fulfill()
        })

        wait(for: [renderedExpectation], timeout: 2)
        XCTAssertEqual(capturedIsEnabled, true)
    }

    @MainActor
    func test_whenDialogIsPresented_thenBackgroundContentIsDisabled() {
        let renderedExpectation = expectation(description: "EnabledProbe rendered")
        var capturedIsEnabled: Bool?
        host(dialogView(isPresented: true) { isEnabled in
            capturedIsEnabled = isEnabled
            renderedExpectation.fulfill()
        })

        wait(for: [renderedExpectation], timeout: 2)
        XCTAssertEqual(capturedIsEnabled, false)
    }
}

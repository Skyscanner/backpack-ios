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

import Darwin
import SwiftUI
import UIKit
import XCTest
@testable import Backpack_SwiftUI

/// Regression coverage for DON-3708: with an external keyboard / Full Keyboard Access, background
/// content behind a `bpkSuccessDialogView` (and friends) remained reachable and activatable.
/// `.isModal` is only honoured by VoiceOver, and `.accessibilityHidden` alone only covers VoiceOver /
/// Switch Control: Full Keyboard Access reaches gesture-based content (e.g. day cells using
/// `.onTapGesture`) via the interaction/focus system, which is what `.disabled` actually switches
/// off. These tests assert both: the background is removed from the accessibility tree, and
/// `\.isEnabled` is `false` for it, while the dialog is presented.
final class DialogContainerViewModifierTests: XCTestCase {
    private enum Label {
        static let background = "Background content"
        static let dialog = "Dialog content"
    }

    private struct EnabledProbe: View {
        @Environment(\.isEnabled) private var isEnabled
        let onRender: (Bool) -> Void

        var body: some View {
            Color.clear
                .frame(width: 1, height: 1)
                .onAppear { onRender(isEnabled) }
        }
    }

    /// Whether the in-process accessibility runtime could be enabled. SwiftUI only materialises its
    /// UIKit accessibility tree when this is active, which it isn't by default in a test host.
    private static let accessibilityRuntimeEnabled: Bool = {
        guard let handle = dlopen("/usr/lib/libAccessibility.dylib", RTLD_NOW) else { return false }
        typealias SetterFn = @convention(c) (Bool) -> Void
        guard let sym = dlsym(handle, "_AXSSetAutomationEnabled") else { return false }
        unsafeBitCast(sym, to: SetterFn.self)(true)
        return true
    }()

    // Keeps hosting windows alive for the duration of a test. A `UIHostingController`'s accessibility
    // tree is torn down once its window is deallocated, so a purely local `UIWindow` would make
    // traversal after `host(_:)` returns unreliable.
    private var retainedWindows: [UIWindow] = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        try XCTSkipUnless(
            Self.accessibilityRuntimeEnabled,
            "Could not enable the in-process accessibility runtime (libAccessibility.dylib / " +
                "_AXSSetAutomationEnabled unavailable); skipping accessibility-tree assertions."
        )
    }

    override func tearDown() {
        retainedWindows.removeAll()
        super.tearDown()
    }

    @discardableResult
    private func host<V: View>(_ view: V) -> UIHostingController<V> {
        let hostController = UIHostingController(rootView: view)
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 700))
        window.rootViewController = hostController
        window.makeKeyAndVisible()
        hostController.view.layoutIfNeeded()
        retainedWindows.append(window)
        return hostController
    }

    /// Polls the accessibility tree until it contains `label`, or `timeout` elapses, then returns
    /// whatever labels are present at that point. This exits as soon as the tree is ready instead of
    /// sleeping for a fixed duration, so it's both faster and deterministic: a label that never
    /// appears causes the subsequent assertion to fail rather than being masked by an arbitrary delay.
    private func accessibilityLabels<V: View>(
        for view: V,
        waitingFor label: String,
        timeout: TimeInterval = 2
    ) -> [String] {
        let hostController = host(view)
        let deadline = Date().addingTimeInterval(timeout)
        var labels: [String] = []

        repeat {
            labels = Self.collectAccessibilityLabels(from: hostController.view)
            if labels.contains(label) { break }
            RunLoop.current.run(until: Date().addingTimeInterval(0.02))
        } while Date() < deadline

        return labels
    }

    private static func collectAccessibilityLabels(from root: UIView) -> [String] {
        var labels: [String] = []
        func walk(_ object: NSObject, depth: Int) {
            if depth > 20 { return }
            let isElement = (object as? UIView)?.isAccessibilityElement ?? object.isAccessibilityElement
            if isElement, let label = object.accessibilityLabel {
                labels.append(label)
            }
            if let elements = object.accessibilityElements as? [NSObject], !elements.isEmpty {
                for element in elements { walk(element, depth: depth + 1) }
            }
            if let view = object as? UIView {
                for subview in view.subviews { walk(subview, depth: depth + 1) }
            }
        }
        walk(root, depth: 0)
        return labels
    }

    private func dialogView(isPresented: Bool) -> some View {
        BPKText(Label.background)
            .accessibilityLabel(Label.background)
            .modifier(DialogContainerViewModifier(
                isPresented: .constant(isPresented),
                dialogContent: {
                    BPKText(Label.dialog)
                        .accessibilityLabel(Label.dialog)
                },
                onTouchOutside: {}
            ))
    }

    func test_whenDialogIsNotPresented_thenBackgroundContentIsAccessible() {
        let labels = accessibilityLabels(for: dialogView(isPresented: false), waitingFor: Label.background)

        XCTAssertTrue(labels.contains(Label.background))
    }

    func test_whenDialogIsPresented_thenBackgroundContentIsHiddenFromAccessibility() {
        let labels = accessibilityLabels(for: dialogView(isPresented: true), waitingFor: Label.dialog)

        XCTAssertFalse(labels.contains(Label.background))
        XCTAssertTrue(labels.contains(Label.dialog))
    }

    func test_whenDialogIsNotPresented_thenBackgroundContentIsEnabled() {
        let renderedExpectation = expectation(description: "EnabledProbe rendered")
        var capturedIsEnabled: Bool?
        host(
            EnabledProbe { isEnabled in
                capturedIsEnabled = isEnabled
                renderedExpectation.fulfill()
            }
            .modifier(DialogContainerViewModifier(
                isPresented: .constant(false),
                dialogContent: { BPKText(Label.dialog) },
                onTouchOutside: {}
            ))
        )

        wait(for: [renderedExpectation], timeout: 2)
        XCTAssertEqual(capturedIsEnabled, true)
    }

    func test_whenDialogIsPresented_thenBackgroundContentIsDisabled() {
        let renderedExpectation = expectation(description: "EnabledProbe rendered")
        var capturedIsEnabled: Bool?
        host(
            EnabledProbe { isEnabled in
                capturedIsEnabled = isEnabled
                renderedExpectation.fulfill()
            }
            .modifier(DialogContainerViewModifier(
                isPresented: .constant(true),
                dialogContent: { BPKText(Label.dialog) },
                onTouchOutside: {}
            ))
        )

        wait(for: [renderedExpectation], timeout: 2)
        XCTAssertEqual(capturedIsEnabled, false)
    }
}

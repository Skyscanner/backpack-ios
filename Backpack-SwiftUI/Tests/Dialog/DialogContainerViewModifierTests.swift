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

    override class func setUp() {
        // SwiftUI only materialises its UIKit accessibility tree when the accessibility runtime is
        // active in-process, which it isn't by default in a test host. Without this, every assertion
        // below would silently pass on an empty tree regardless of the code change.
        guard let handle = dlopen("/usr/lib/libAccessibility.dylib", RTLD_NOW) else { return }
        typealias SetterFn = @convention(c) (Bool) -> Void
        if let sym = dlsym(handle, "_AXSSetAutomationEnabled") {
            unsafeBitCast(sym, to: SetterFn.self)(true)
        }
    }

    @discardableResult
    private func host<V: View>(_ view: V) -> UIHostingController<V> {
        let host = UIHostingController(rootView: view)
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 700))
        window.rootViewController = host
        window.makeKeyAndVisible()
        host.view.layoutIfNeeded()
        RunLoop.current.run(until: Date().addingTimeInterval(0.3))
        return host
    }

    private func accessibilityLabels<V: View>(_ view: V) -> [String] {
        let hostController = host(view)

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
        walk(hostController.view, depth: 0)
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
        let labels = accessibilityLabels(dialogView(isPresented: false))

        XCTAssertTrue(labels.contains(Label.background))
    }

    func test_whenDialogIsPresented_thenBackgroundContentIsHiddenFromAccessibility() {
        let labels = accessibilityLabels(dialogView(isPresented: true))

        XCTAssertFalse(labels.contains(Label.background))
        XCTAssertTrue(labels.contains(Label.dialog))
    }

    func test_whenDialogIsNotPresented_thenBackgroundContentIsEnabled() {
        var capturedIsEnabled: Bool?
        host(
            EnabledProbe { capturedIsEnabled = $0 }
                .modifier(DialogContainerViewModifier(
                    isPresented: .constant(false),
                    dialogContent: { BPKText(Label.dialog) },
                    onTouchOutside: {}
                ))
        )

        XCTAssertEqual(capturedIsEnabled, true)
    }

    func test_whenDialogIsPresented_thenBackgroundContentIsDisabled() {
        var capturedIsEnabled: Bool?
        host(
            EnabledProbe { capturedIsEnabled = $0 }
                .modifier(DialogContainerViewModifier(
                    isPresented: .constant(true),
                    dialogContent: { BPKText(Label.dialog) },
                    onTouchOutside: {}
                ))
        )

        XCTAssertEqual(capturedIsEnabled, false)
    }
}

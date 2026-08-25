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

class BPKSnippetAccessibilityTests: XCTestCase {
    override class func setUp() {
        // SwiftUI only materialises its UIKit accessibility tree when the
        // accessibility runtime is active in-process, which it isn't by
        // default in a test host. Without this, every trait assertion below
        // would silently pass on an empty tree regardless of the code change.
        guard let handle = dlopen("/usr/lib/libAccessibility.dylib", RTLD_NOW) else { return }
        typealias SetterFn = @convention(c) (Bool) -> Void
        if let sym = dlsym(handle, "_AXSSetAutomationEnabled") {
            unsafeBitCast(sym, to: SetterFn.self)(true)
        }
    }

    private func combinedElementTraits<V: View>(_ view: V) -> UIAccessibilityTraits? {
        let host = UIHostingController(rootView: view)
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 700))
        window.rootViewController = host
        window.makeKeyAndVisible()
        host.view.layoutIfNeeded()
        RunLoop.current.run(until: Date().addingTimeInterval(0.3))

        var found: UIAccessibilityTraits?
        func walk(_ object: NSObject, depth: Int) {
            if depth > 14 || found != nil { return }
            let isElement = (object as? UIView)?.isAccessibilityElement ?? object.isAccessibilityElement
            if isElement {
                found = object.accessibilityTraits
                return
            }
            if let elements = object.accessibilityElements as? [NSObject], !elements.isEmpty {
                for element in elements { walk(element, depth: depth + 1) }
            }
            if let view = object as? UIView {
                for subview in view.subviews { walk(subview, depth: depth + 1) }
            }
        }
        walk(host.view, depth: 0)
        return found
    }

    private func snippet(
        accessibilityHeaderEnabled: Bool = true,
        onClick: (() -> Void)? = nil
    ) -> BPKSnippet {
        BPKSnippet(
            image: Image("dialog_image", bundle: TestsBundle.bundle),
            headline: "Headline Text",
            subheading: "Subheading",
            bodyText: "Body Text",
            accessibilityHeaderEnabled: accessibilityHeaderEnabled,
            onClick: onClick
        )
    }

    func test_defaultAccessibilityHeaderEnabledWithOnClick_matchesCurrentBehaviour() {
        let traits = combinedElementTraits(snippet(onClick: {}))
        XCTAssertEqual(traits?.contains(.header), true)
        XCTAssertEqual(traits?.contains(.button), true)
    }

    func test_accessibilityHeaderEnabledFalse_removesHeaderTraitOnly() {
        let traits = combinedElementTraits(snippet(accessibilityHeaderEnabled: false, onClick: {}))
        XCTAssertEqual(traits?.contains(.header), false)
        XCTAssertEqual(traits?.contains(.button), true)
    }

    func test_noOnClick_removesButtonTraitOnly() {
        let traits = combinedElementTraits(snippet(accessibilityHeaderEnabled: true, onClick: nil))
        XCTAssertEqual(traits?.contains(.header), true)
        XCTAssertEqual(traits?.contains(.button), false)
    }

    func test_accessibilityHeaderEnabledFalseAndNoOnClick_removesBothTraits() {
        let traits = combinedElementTraits(snippet(accessibilityHeaderEnabled: false, onClick: nil))
        XCTAssertEqual(traits?.contains(.header), false)
        XCTAssertEqual(traits?.contains(.button), false)
    }
}

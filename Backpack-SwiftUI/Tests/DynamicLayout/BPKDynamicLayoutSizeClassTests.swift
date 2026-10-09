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

final class BPKDynamicLayoutSizeClassTests: XCTestCase {
    private let itemSide: CGFloat = 40

    func test_whenWindowIsCompact_thenUsesTheSecondaryLayout() {
        XCTAssertEqual(idealSize(horizontalSizeClass: .compact), CGSize(width: itemSide, height: itemSide * 2))
    }

    func test_whenWindowIsRegular_thenUsesThePrimaryLayout() {
        XCTAssertEqual(idealSize(horizontalSizeClass: .regular), CGSize(width: itemSide * 2, height: itemSide))
    }

    func test_whenBindingInitialiserIsUsed_thenSizeClassIsIgnored() {
        let view = BPKDynamicLayout(
            primaryLayout: AnyLayout(HStackLayout(spacing: 0)),
            secondaryLayout: AnyLayout(VStackLayout(spacing: 0)),
            activateSecondaryLayout: .constant(false)
        ) {
            items
        }
        .environment(\.horizontalSizeClass, .compact)

        XCTAssertEqual(fittingSize(of: view), CGSize(width: itemSide * 2, height: itemSide))
    }

    // MARK: - Helpers

    private var items: some View {
        Group {
            Color.clear.frame(width: itemSide, height: itemSide)
            Color.clear.frame(width: itemSide, height: itemSide)
        }
    }

    private func idealSize(horizontalSizeClass: UserInterfaceSizeClass) -> CGSize {
        let view = BPKDynamicLayout(
            primaryLayout: AnyLayout(HStackLayout(spacing: 0)),
            secondaryLayout: AnyLayout(VStackLayout(spacing: 0)),
            secondaryLayoutForHorizontalSizeClass: .compact
        ) {
            items
        }
        .environment(\.horizontalSizeClass, horizontalSizeClass)
        return fittingSize(of: view)
    }

    private func fittingSize<V: View>(of view: V) -> CGSize {
        UIHostingController(rootView: view).sizeThatFits(in: CGSize(width: 1000, height: 1000))
    }
}

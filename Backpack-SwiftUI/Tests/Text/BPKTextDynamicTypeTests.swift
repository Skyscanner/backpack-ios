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

class BPKTextDynamicTypeTests: XCTestCase {
    private let categories: [(UIContentSizeCategory, String)] = [
        (.extraSmall, "xs"),
        (.large, "l"),
        (.accessibilityMedium, "a11y_m"),
        (.accessibilityExtraExtraExtraLarge, "a11y_3xl")
    ]
    
    func test_dynamicType() {
        let sut = generateView([
            (.hero1, "Hero 1"),
            (.heading1, "Heading 1"),
            (.bodyDefault, "Body default"),
            (.caption, "Caption"),
            (.footnote, "Footnote")
        ]).frame(width: 600, height: 360)

        let view: UIView = UIHostingController(rootView: sut).view

        categories.forEach { category in
            assertSnapshot(matching: view, as: .image(size: view.intrinsicContentSize, traits: .init(preferredContentSizeCategory: category.0)), named: "dynamic_type_\(category.1)")
        }
    }
    
    private func generateView(_ styles: [(BPKFontStyle, String)]) -> some View {
        VStack(alignment: .leading) {
            ForEach(styles, id: \.self.1) { style in
                BPKText(style.1, style: style.0)
            }
            Spacer()
        }
    }
}

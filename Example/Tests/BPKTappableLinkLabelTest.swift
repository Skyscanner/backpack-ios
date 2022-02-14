/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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
import Backpack

class BPKTappableLinkLabelTest: XCTestCase {
    func testSettingText() {
        let label = BPKTappableLinkLabel(frame: .zero)
        label.text = "Hello world"
        label.addLink(to: URL(string: "https")!, with: NSRange(location: 0, length: 5))
        XCTAssertEqual(label.text, "Hello world")
    }
}

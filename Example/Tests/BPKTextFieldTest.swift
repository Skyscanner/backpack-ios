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
import Backpack

class BPKTextFieldTest: XCTestCase {
    func testInitWithFontStyle() throws {
        
        let styles: [BPKFontStyle] = [
            .textHero1,
            .textHero2,
            .textHero3,
            .textHero4,
            .textHero5,
            .textHeading5,
            .textHeading4,
            .textHeading3,
            .textHeading2,
            .textHeading1,
            .textSubheading,
            .textBodyLongform,
            .textBodyDefault,
            .textLabel2,
            .textLabel1,
            .textFootnote,
            .textCaption
        ]
        try styles.map { style -> BPKTextField in
            let textField = BPKTextField(fontStyle: style)
            textField.text = "Hello world"
            return textField
        }.forEach { fiel in
            var range = NSRange(location: 0, length: fiel.text!.count)
            let attributes = fiel.attributedText!.attributes(at: 0, effectiveRange: &range)
            XCTAssertNotNil(attributes[.font])
            XCTAssertEqual(try XCTUnwrap(attributes[.foregroundColor] as? UIColor), BPKColor.textPrimaryColor)
        }
    }
}

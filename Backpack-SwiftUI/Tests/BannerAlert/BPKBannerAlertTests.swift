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

class BPKInfoBannerTests: XCTestCase {
    private var styles: [BPKBannerAlert.Style] {
        [.default, .onContrast]
    }
    
    func test_infoBannerAlert() {
        print(constructTestName(for: styles[0]))
        print(constructTestName(for: styles[1]))
        styles.forEach { style in
            assertSnapshot(
                BPKBannerAlert(type: .info(), style: style, message: "Read before booking")
                    .frame(width: 300),
                testName: constructTestName(for: style)
            )
        }
    }
    
    func test_successBannerAlert() {
        styles.forEach { style in
            assertSnapshot(
                BPKBannerAlert(type: .success(), style: style, message: "Success Alert")
                    .frame(width: 300),
                testName: constructTestName(for: style)
            )
        }
    }
    
    func test_warningBannerAlert() {
        styles.forEach { style in
            assertSnapshot(
                BPKBannerAlert(type: .warning(), style: style, message: "Warning Alert")
                    .frame(width: 300),
                testName: constructTestName(for: style)
            )
        }
    }
    
    func test_errorBannerAlert() {
        styles.forEach { style in
            assertSnapshot(
                BPKBannerAlert(type: .error(), style: style, message: "Error Alert")
                    .frame(width: 300),
                testName: constructTestName(for: style)
            )
        }
    }
    
    func test_multilineBannerAlert() {
        styles.forEach { style in
            assertSnapshot(
                BPKBannerAlert(type: .error(), style: style, message: "Multiline Alert \nNewLine")
                    .frame(width: 300)
            )
        }
    }
    
    func test_accessibilityDynamicType() {
        assertA11ySnapshot(
            BPKBannerAlert(type: .error(), style: .default, message: "Multiline Alert \nNewLine")
        )
    }
    
    private func constructTestName(for style: BPKBannerAlert.Style, function: String = #function) -> String {
        let style = "\(style)".capitalized
        return "\(function.dropLast(2))With\(style)Style"
    }
}

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

class BPKDialogTests: XCTestCase {
    private func textContent(_ contentAlignment: HorizontalAlignment) -> DialogTextContent {
        DialogTextContent(
            title: "Title in here",
            text: "Description that goes two lines ideally, but sometimes it can go longer",
            contentAlignment: contentAlignment
        )
    }
    
    private var actions: DialogActionsView {
        DialogActionsView(buttons: [
            BPKDialogButton("Confirmation") {},
            BPKDialogButton("Confirmation") {}
        ])
    }
    
    func test_iconDialog() {
        assertSnapshot(
            DialogWithIconContent(
                icon: .tick,
                iconColor: .coreAccentColor,
                textContent: textContent(.center),
                actions: actions
            )
            .frame(width: 400)
        )
    }
    
    func test_customHeaderDialog() {
        assertSnapshot(
            DialogWithHeaderContent(
                textContent: textContent(.leading),
                actions: actions
            ) {
                DialogImageView(image: Image("dialog_image", bundle: TestsBundle.bundle))
            }
                .frame(width: 400)
        )
    }
}

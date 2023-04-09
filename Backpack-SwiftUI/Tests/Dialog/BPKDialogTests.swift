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
    private var backgroundView: some View {
        Color(.canvasColor)
            .frame(width: 500, height: 400)
    }
    
    func test_successDialog() {
        assertSnapshot(
            backgroundView
                .bpkSuccessDialog(
                    presented: .constant(true),
                    title: "Title in here",
                    text: "Description that goes two lines ideally, but sometimes it can go longer",
                    confirmButton: BPKDialogButton("Confirmation") {},
                    secondaryButton: BPKDialogButton("Skip") {},
                    linkButton: BPKDialogButton("Link optional") {}
                )
        )
    }
    
    func test_warningDialog() {
        assertSnapshot(
            backgroundView
                .bpkWarningDialog(
                    presented: .constant(true),
                    title: "Title in here",
                    text: "Description that goes two lines ideally, but sometimes it can go longer",
                    confirmButton: BPKDialogButton("Confirmation") {},
                    secondaryButton: BPKDialogButton("Skip") {},
                    linkButton: BPKDialogButton("Link optional") {}
                )
        )
    }
    
    func test_destructiveDialog() {
        assertSnapshot(
            backgroundView
                .bpkDestructiveDialog(
                    presented: .constant(true),
                    title: "Delete",
                    text: "Description that goes two lines ideally, but sometimes it can go longer",
                    confirmButton: BPKDialogButton("Delete") {},
                    linkButton: BPKDialogButton("Cancel") {}
                )
        )
    }
    
    func test_imageDialog() {
        assertSnapshot(
            backgroundView
                .bpkImageDialog(
                    presented: .constant(true),
                    image: Image("dialog_image", bundle: TestsBundle.bundle),
                    title: "Title in here",
                    text: "Description that goes two lines ideally, but sometimes it can go longer",
                    confirmButton: BPKDialogButton("Confirmation") {},
                    secondaryButton: BPKDialogButton("Skip") {},
                    linkButton: BPKDialogButton("Link optional") {}
                )
        )
    }
    
    func test_flareDialog() {
        assertSnapshot(
            backgroundView
                .bpkFlareDialog(
                    presented: .constant(true),
                    image: Image("dialog_flare", bundle: TestsBundle.bundle),
                    title: "Title in here",
                    text: "Description that goes two lines ideally, but sometimes it can go longer",
                    confirmButton: BPKDialogButton("Confirmation") {},
                    secondaryButton: BPKDialogButton("Skip") {},
                    linkButton: BPKDialogButton("Link optional") {}
                )
        )
    }
}

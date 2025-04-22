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

class BPKImageGalleryPreviewTests: XCTestCase {
    private func createImage() -> some View {
        Image("dialog_image", bundle: TestsBundle.bundle)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    func test_imageGalleryPreview() {
        assertSnapshot(
            BPKImageGalleryPreview(
                images: [
                    createImage(),
                    createImage(),
                    createImage()
                ],
                currentIndex: .constant(1)
            )
            .frame(width: 400, height: 250)
        )
    }
    
    func test_imageGalleryPreview_inlineVariant() {
        assertSnapshot(
            BPKImageGalleryPreview(
                image: createImage(),
                inlineButtonTitle: "View Photos")
            .frame(width: 375, height: 217)
        )
    }
}

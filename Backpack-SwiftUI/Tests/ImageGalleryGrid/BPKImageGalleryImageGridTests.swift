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

class BPKImageGalleryImageGridTests: XCTestCase {
    private func createImage(_ context: BPKImageGalleryDisplayContext) -> some View {
        Image("dialog_image", bundle: TestsBundle.bundle)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    func test_imageGalleryImageGrid() {
        assertSnapshot(
            ImageGalleryGridContentView(
                categories: .image((0...3).map { _ in
                    BPKImageGalleryImageGridStyle.ImageCategory(
                        title: "title",
                        images: (0...4).map { _ in
                            .init(
                                title: "Title for the image",
                                description: "The description of the image goes here.",
                                credit: "Backpack Photographer",
                                content: createImage
                            )
                        },
                        categoryImage: {
                            self.createImage(.grid)
                        }
                    )
                }),
                closeAccessibilityLabel: "",
                itemTapped: { _ in },
                onCloseTapped: { },
                selectedCategoryIndex: .constant(0)
            )
            .frame(width: 400, height: 600)
        )
    }
}

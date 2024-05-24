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

class ImageGalleryGridTests: XCTestCase {
    private func createImage() -> some View {
        Image("dialog_image", bundle: TestsBundle.bundle)
            .resizable()
    }
    
    func test_imageGalleryChipGrid() {
        assertSnapshot(
            ImageGalleryGridContentView(
                categories: {
                    ImageGalleryChipCategoryView(
                        categories: (0...3).map { "category \($0)" },
                        selectedCategoryIndex: .constant(1)
                    )
                },
                gridImages: (0...4).map { _ in .init(content: createImage) },
                slideshowImages: (0...4).map { _ in
                    .init(
                        title: "Title for the image",
                        description: "The description of the image goes here.",
                        credit: "Backpack Photographer",
                        content: createImage
                    )
                },
                closeAccessibilityLabel: "close",
                imageTapped: { _, _ in },
                onCloseTapped: {},
                selectedCategoryIndex: 1
            )
            .frame(width: 400, height: 600)
        )
    }
    
    func test_imageGalleryImagesGrid() {
        assertSnapshot(
            ImageGalleryGridContentView(
                categories: {
                    ImageGalleryImageCategoryView(
                        categories: (0...4).map {
                            .init(
                                title: "Category \($0)",
                                categoryImage: self.createImage
                            )
                        },
                        selectedCategory: .constant(1)
                    )
                },
                gridImages: (0...4).map { _ in .init(content: createImage) },
                slideshowImages: (0...4).map { _ in
                    .init(
                        title: "Title for the image",
                        description: "The description of the image goes here.",
                        credit: "Backpack Photographer",
                        content: createImage
                    )
                },
                closeAccessibilityLabel: "close",
                imageTapped: { _, _ in },
                onCloseTapped: {},
                selectedCategoryIndex: 1
            )
            .frame(width: 400, height: 600)
        )
    }
}

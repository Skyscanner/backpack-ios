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

import SwiftUI

public struct BPKImageGalleryChipCategory<GridImageView: View, SlideshowImageView: View> {
    public let title: String
    public let gridImages: [BPKGridGalleryImage<GridImageView>]
    public let slideshowImages: [BPKSlideshowGalleryImage<SlideshowImageView>]
    
    public init(
        title: String,
        gridImages: [BPKGridGalleryImage<GridImageView>],
        slideshowImages: [BPKSlideshowGalleryImage<SlideshowImageView>]
    ) {
        self.title = title
        self.gridImages = gridImages
        self.slideshowImages = slideshowImages
    }
}

public struct BPKImageGalleryImageCategory<CategoryImageView: View, GridImageView: View, SlideshowImageView: View> {
    public let title: String
    public let gridImages: [BPKGridGalleryImage<GridImageView>]
    public let slideshowImages: [BPKSlideshowGalleryImage<SlideshowImageView>]
    public let categoryImage: () -> CategoryImageView

    public init(
        title: String,
        gridImages: [BPKGridGalleryImage<GridImageView>],
        slideshowImages: [BPKSlideshowGalleryImage<SlideshowImageView>],
        categoryImage: @escaping () -> CategoryImageView
    ) {
        self.title = title
        self.gridImages = gridImages
        self.slideshowImages = slideshowImages
        self.categoryImage = categoryImage
    }
}

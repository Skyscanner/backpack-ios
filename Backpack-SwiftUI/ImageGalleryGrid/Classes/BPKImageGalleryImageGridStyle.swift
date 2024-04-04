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

public enum BPKImageGalleryImageGridStyle<ImageView: View> {
    case chip(_ categories: [ChipCategory])
    case image(_ categories: [ImageCategory])
    
    public struct ChipCategory {
        public let title: String
        public let images: [BPKImageGalleryImage<ImageView>]
        
        public init(
            title: String,
            images: [BPKImageGalleryImage<ImageView>]
        ) {
            self.title = title
            self.images = images
        }
    }
    
    public struct ImageCategory {
        public let title: String
        public let images: [BPKImageGalleryImage<ImageView>]
        public let categoryImage: () -> ImageView

        public init(
            title: String,
            images: [BPKImageGalleryImage<ImageView>],
            categoryImage: @escaping () -> ImageView
        ) {
            self.title = title
            self.images = images
            self.categoryImage = categoryImage
        }
    }
}

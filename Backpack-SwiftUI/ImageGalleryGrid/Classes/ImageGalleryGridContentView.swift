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

struct ImageGalleryGridContentView<Categories: View, GridImageView: View, SlideshowImageView: View>: View {
    private let itemHeightInGrid: CGFloat = 192
    let categories: () -> Categories
    let gridImages: [BPKGridGalleryImage<GridImageView>]
    let slideshowImages: [BPKSlideshowGalleryImage<SlideshowImageView>]
    let closeAccessibilityLabel: String
    let imageTapped: (_ category: Int, _ image: Int) -> Void
    let onCloseTapped: () -> Void
    
    let selectedCategoryIndex: Int
    @State var isSlideshowPresented: Bool = false
    @State var imageIndexInCategory: Int = 0
    
    var body: some View {
        VStack(spacing: .base) {
            header
            VStack(spacing: 12) {
                categories()
                ScrollViewReader { proxy in
                    TwoRowGrid(
                        items: gridImages
                    ) { item, index in
                        item.content()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .frame(height: itemHeightInGrid)
                            .accessibilityAddTraits(.isButton)
                            .onTapGesture {
                                imageTapped(selectedCategoryIndex, index)
                                imageIndexInCategory = index
                                isSlideshowPresented.toggle()
                            }
                            .onChange(of: selectedCategoryIndex) { index in
                                proxy.scrollTo(0)
                            }
                    }
                    .padding(.horizontal, .lg)
                }
            }
            .padding(.bottom, .base)
        }
        .background(Color(.canvasContrastColor))
        .bpkImageGallerySlideshow(
            isPresented: $isSlideshowPresented,
            images: slideshowImages,
            closeAccessibilityLabel: closeAccessibilityLabel,
            currentIndex: $imageIndexInCategory,
            onCloseTapped: { isSlideshowPresented = false }
        )
    }
    
    var header: some View {
        ImageGalleryHeader(
            closeAccessibilityLabel: closeAccessibilityLabel,
            onCloseTapped: onCloseTapped
        )
        .padding(.horizontal, .base)
        .padding(.top, .md)
    }
}

struct ImageGalleryGridContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryGridContentView(
            categories: {
                Text("categories")
            },
            gridImages: [
                .init(content: { Color.red }),
                .init(content: { Color.green })
            ],
            slideshowImages: [
                .init(title: "Image", content: {
                    Color.red
                }),
                .init(title: "Image 2", content: {
                    Color.green
                })
            ],
            closeAccessibilityLabel: "Close",
            imageTapped: { _, _ in },
            onCloseTapped: {},
            selectedCategoryIndex: 0,
            isSlideshowPresented: false,
            imageIndexInCategory: 0
        )
    }
}

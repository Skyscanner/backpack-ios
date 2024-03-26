//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
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
import Backpack_SwiftUI

struct ImageGalleryGridExampleView: View {
    @State var imageGalleriesIsPresented = false
    @State var chipGalleriesIsPresented = false
    var body: some View {
        // swiftlint:disable closure_body_length
        VStack {
            BPKButton("Show Chip Categories", action: {
                chipGalleriesIsPresented.toggle()
            })
            .bpkImageGalleryGrid(
                isPresented: $chipGalleriesIsPresented,
                categories: .chip(
                    (0...7).map { categoryIndex in
                        BPKImageGalleryCategoryChip(
                            title: categoryName(categoryIndex),
                            images: (0...categoryIndex).map { index in
                                BPKImageGalleryImage(
                                    title: "image \(index)",
                                    description: "Image at Index: \(index)",
                                    credit: "@photographer"
                                ) {
                                    image(index)
                                }
                            }
                        )
                    }
                ),
                closeAccessibilityLabel: "Close",
                onCategoryChanged: { category in
                    print("onCategoryChanged: \(category.title)")
                },
                onItemTapped: { category, item in
                    print("onItemTapped category: \(category.title), item: \(item)")
                },
                onCloseTapped: { chipGalleriesIsPresented = false }
            )
            
            BPKButton("Show Image Categories", action: {
                imageGalleriesIsPresented.toggle()
            })
            .bpkImageGalleryGrid(
                isPresented: $imageGalleriesIsPresented,
                categories: .image(
                    (0...7).map { categoryIndex in
                        BPKImageGalleryCategoryImage(
                            title: categoryName(categoryIndex),
                            images: (0...categoryIndex).map { index in
                                BPKImageGalleryImage(
                                    title: "image \(index)",
                                    description: "Image at Index: \(index)",
                                    credit: "@photographer"
                                ) {
                                    image(index)
                                }
                            },
                            categoryImage: BPKImageGalleryCarouselImage() {
                                image(categoryIndex)
                            }
                        )
                    }
                ),
                closeAccessibilityLabel: "Close",
                onCategoryChanged: { category in
                    print("onCategoryChanged: \(category.title)")
                },
                onItemTapped: { category, item in
                    print("onItemTapped category: \(category.title), item: \(item)")
                },
                onCloseTapped: { imageGalleriesIsPresented = false }
            )
        }
    }
    
    private func categoryName(_ categoryIndex: Int) -> String {
        switch categoryIndex % 2 {
        case 0:
            return "Long Category Name For Photos (\(categoryIndex))"
        default:
            return "Short (\(categoryIndex))"
        }
    }
    
    private func image(_ number: Int) -> some View {
        let imageFileNumber = (number % 4) + 1
        return ZStack {
            Image("carousel_placeholder_\(imageFileNumber)")
                .resizable()
            
            BPKText("\(number)", style: .heading1)
                .foregroundColor(.textPrimaryInverseColor)
        }
    }
}

struct ImageGalleryGridExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryGridExampleView()
    }
}

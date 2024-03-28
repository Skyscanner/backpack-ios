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
    
    var body: some View {
        VStack {
            ButtonForChipGroup(categoryName: categoryName(_:), image: image(_:context:))
            ButtonForImageGroup(categoryName: categoryName(_:), image: image(_:context:))
        }
    }
    
    struct ButtonForImageGroup<ImageView: View>: View {
        @State var imageGalleriesIsPresented = false
        @State var imageGalleriesCategory = 0
        let categoryName: (Int) -> String
        let image: (Int, BPKImageGalleryDisplayContext) -> ImageView
        
        var body: some View {
            BPKButton("Show Image Categories NEW", action: {
                imageGalleriesIsPresented.toggle()
            })
            .bpkImageGalleryGrid(
                isPresented: $imageGalleriesIsPresented,
                category: $imageGalleriesCategory,
                categories: (0...7).map { categoryIndex in
                    BPKImageGalleryImageGridStyle.ImageCategory(
                        title: categoryName(categoryIndex),
                        images: (0...categoryIndex).map { index in
                            BPKImageGalleryImage(
                                title: "image \(index)",
                                description: "Image at Index: \(index)",
                                credit: "@photographer"
                            ) { context in
                                image(index, context)
                            }
                        },
                        categoryImage: {
                            image(categoryIndex, .grid)
                        }
                    )
                },
                closeAccessibilityLabel: "Close",
                onItemTapped: { category, item in
                    print("onItemTapped category: \(category.title), item: \(item)")
                },
                onCloseTapped: { imageGalleriesIsPresented = false }
            ).onChange(of: imageGalleriesCategory) { _ in
                print("category index: \(imageGalleriesCategory)")
            }
        }
    }
    
    struct ButtonForChipGroup<ImageView: View>: View {
        @State var chipGalleriesIsPresented = false
        @State var chipGalleriesCategory = 0
        let categoryName: (Int) -> String
        let image: (Int, BPKImageGalleryDisplayContext) -> ImageView
        
        var body: some View {
            BPKButton("Show Chip Categories", action: {
                chipGalleriesIsPresented.toggle()
            })
            .bpkImageGalleryGrid(
                isPresented: $chipGalleriesIsPresented,
                category: $chipGalleriesCategory,
                categories: (0...7).map { categoryIndex in
                    BPKImageGalleryImageGridStyle.ChipCategory(
                        title: categoryName(categoryIndex),
                        images: (0...categoryIndex).map { index in
                            BPKImageGalleryImage(
                                title: "image \(index)",
                                description: "Image at Index: \(index)",
                                credit: "@photographer"
                            ) { context in
                                image(index, context)
                            }
                        }
                    )
                },
                closeAccessibilityLabel: "Close",
                onItemTapped: { category, item in
                    print("onItemTapped category: \(category.title), item: \(item)")
                },
                onCloseTapped: { chipGalleriesIsPresented = false }
            )
            .onChange(of: chipGalleriesCategory) { _ in
                print("category index: \(chipGalleriesCategory)")
            }
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
    
    private func image(_ number: Int, context: BPKImageGalleryDisplayContext) -> some View {
        let imageFileNumber = (number % 4) + 1
        return ZStack {
            Image("carousel_placeholder_\(imageFileNumber)")
                .resizable()
            
            BPKText("\(context == .grid ? "G": "S") - \(number)", style: .heading1)
                .foregroundColor(.textPrimaryInverseColor)
        }
    }
}

struct ImageGalleryGridExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryGridExampleView()
    }
}

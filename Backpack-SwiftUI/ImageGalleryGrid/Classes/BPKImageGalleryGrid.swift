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

struct ImageGalleryGrid<ImageView: View>: ViewModifier {
    let categories: [BPKImageGalleryCategory<ImageView>]
    let closeAccessibilityLabel: String
    let onCloseTapped: () -> Void
    // @Binding var currentIndex: Int // Category Selected binding?
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented, content: {
                ContentView(categories: categories)
            })
    }
    
    struct ContentView: View {
        let categories: [BPKImageGalleryCategory<ImageView>]
        @State var selectedCategory: Int = 0
        var body: some View {
            VStack(spacing: .md) {
                ImageGalleryGridCategoriesCarousel(
                    categories: categories,
                    selectedCategory: $selectedCategory
                )
                .fixedSize(horizontal: false, vertical: true)
                
                ImageGalleryGridImagesGrid(
                    images: categories[selectedCategory].images
                )
            }
        }
    }
}

public extension View {
    func bpkImageGalleryGrid<Content>(
        isPresented: Binding<Bool>,
        categories: [BPKImageGalleryCategory<Content>],
        closeAccessibilityLabel: String,
        // currentIndex: Binding<Int>, // Category Selected binding?
        onCloseTapped: @escaping () -> Void
    ) -> some View {
        modifier(
            ImageGalleryGrid(
                categories: categories,
                closeAccessibilityLabel: closeAccessibilityLabel,
                onCloseTapped: onCloseTapped,
                isPresented: isPresented
            )
        )
    }
}

struct ImageGalleryGridCategoriesCarousel<ImageView: View>: View {
    let categories: [BPKImageGalleryCategory<ImageView>]
    @Binding var selectedCategory: Int
    private let categoryImageSideLength: CGFloat = 90
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(0..<categories.count, id: \.self) { ndx in
                    categoryThumb(for: categories[ndx])
                        .onTapGesture {
                            selectedCategory = ndx
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private func categoryThumb(for category: BPKImageGalleryCategory<ImageView>) -> some View {
        VStack {
            category.categoryImage.content()
                .frame(
                    width: categoryImageSideLength,
                    height: categoryImageSideLength
                )
                .clipShape(RoundedRectangle(cornerRadius: .md))
            BPKText(category.title)
                .lineLimit(nil)
        }
        .frame(width: categoryImageSideLength)
        .fixedSize()
    }
}

struct ImageGalleryGridImagesGrid<ImageView: View>: View {
    
    struct GroupUIState {
        let firstRowImage: BPKImageGalleryImage<ImageView>
        let secondRowImages: [BPKImageGalleryImage<ImageView>]
    }
    
    let images: [BPKImageGalleryImage<ImageView>]
    private let imageGridItemHeight: CGFloat = 192
    private let secondRowImagesCount = 2
    
    private var imageGroups: [ImageGalleryGridImagesGrid.GroupUIState] {
        images.chunked(
            into: 1 + secondRowImagesCount // primary image + images in 2nd row
        ).compactMap { imageGroup in
            
            if imageGroup.count > 0 {
                var imageGroupVar = imageGroup
                let imageOne = imageGroupVar.removeFirst()
                return GroupUIState(
                    firstRowImage: imageOne,
                    secondRowImages: imageGroupVar
                )
            }
            return nil
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(spacing: .md) {
                    ForEach(imageGroups.enumeratedArray(), id: \.offset) { _, imageGroup in
                        imageGroupView(
                            for: imageGroup,
                            containerWidth: geometry.size.width
                            )
                    }
                }
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
            }
        }
    }
    
    @ViewBuilder
    private func imageGroupView(
        for imageGroup: ImageGalleryGridImagesGrid.GroupUIState,
        containerWidth: CGFloat
    ) -> some View {
        VStack {
            imageGroup.firstRowImage.content()
                .frame(height: imageGridItemHeight)
                .clipShape(RoundedRectangle(cornerRadius: .lg))
            
            HStack {
                ForEach(imageGroup.secondRowImages.enumeratedArray(), id: \.offset) { _, image in
                    image.content()
                        .frame(
                            width: containerWidth / CGFloat(imageGroup.secondRowImages.count),
                            height: imageGridItemHeight
                        )
                        .clipShape(RoundedRectangle(cornerRadius: .lg))
                }
            }
        }
    }
}

extension Collection {
    fileprivate func enumeratedArray() -> [(offset: Int, element: Self.Element)] {
        return Array(self.enumerated())
    }
}

extension Array {
    fileprivate func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct BPKImageGalleryGrid_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryGrid<Color>.ContentView(
            categories: testCategories
        )
    }
    
    static var testCategories: [BPKImageGalleryCategory<Color>] {
        [
            BPKImageGalleryCategory(
                title: "green but very long title (40)",
                images: testImages(40, colour: .green),
                categoryImage: testImages(1, colour: .green)[0]
            ),
            BPKImageGalleryCategory(
                title: "blue",
                images: testImages(5, colour: .blue),
                categoryImage: testImages(1, colour: .blue)[0]
            ),
            BPKImageGalleryCategory(
                title: "red",
                images: testImages(6, colour: .red),
                categoryImage: testImages(1, colour: .red)[0]
            )
        ]
    }
    
    static func testImages(_ amount: Int, colour: Color) -> [BPKImageGalleryImage<Color>] {
        return (0..<amount).map { _ in
            BPKImageGalleryImage(
                title: "",
                content: {
                    colour
                }
            )
        }
    }
}

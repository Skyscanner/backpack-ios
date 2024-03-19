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

public struct BPKImageGalleryPreview<Content: View>: View {
    private let images: [Content]
    @Binding private var currentIndex: Int
    private let onImageClicked: ((Int) -> Void)?
    
    public init(
        images: [Content],
        currentIndex: Binding<Int>,
        onImageClicked: ((Int) -> Void)? = nil
    ) {
        self.images = images
        _currentIndex = currentIndex
        self.onImageClicked = onImageClicked
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            InternalCarouselWrapper(
                images: images,
                pageIndicatorVisibility: .hidden,
                currentIndex: $currentIndex
            )
            .if(onImageClicked != nil) { view in
                view.onTapGesture {
                    onImageClicked!(currentIndex)
                }
            }
            BPKPageIndicator(currentIndex: $currentIndex, totalIndicators: .constant(images.count))
                .padding(.bottom, 49)
            BPKBadge("\(currentIndex + 1)/\(images.count)")
                .padding(.trailing, 12)
                .padding(.bottom, 44)
        }
        
    }
}

struct BPKImageGalleryPreview_Previews: PreviewProvider {
    static var previews: some View {
        BPKNavigationView(
            leadingItems: [.init(type: .backButton("Back"), action: {})],
            trailingItems: [
                .init(type: .icon(.shareiOs, "Share"), action: {}),
                .init(type: .icon(.heartOutline, "Save"), action: {})
            ],
            style: .transparent
        ) {
            VStack(alignment: .leading, spacing: BPKSpacing.none) {
                BPKImageGalleryPreview(
                    images: [Color.red, Color.blue],
                    currentIndex: .constant(0)
                )
                .frame(height: 350)
                
                VStack(alignment: .leading) {
                    BPKText("Holiday Inn Express London Heathrow T4", style: .heading3)
                        .lineLimit(nil)
                        .padding(.base)
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: .lg))
                Spacer()
            }
        }
    }
}

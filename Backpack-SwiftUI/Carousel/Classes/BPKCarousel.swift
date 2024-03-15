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
import Backpack_Common

public struct BPKCarousel<Content: View>: View {
    private let images: [Content]
    @Binding private var currentIndex: Int
    
    public init(
        images: [Content],
        currentIndex: Binding<Int>
    ) {
        self.images = images
        _currentIndex = currentIndex
    }
    
    public var body: some View {
        InternalCarouselWrapper(
            images: images,
            pageIndicatorBottomPadding: 0,
            currentIndex: $currentIndex
        )
    }
}

struct InternalCarouselWrapper<Content: View>: UIViewRepresentable {
    let images: [Content]
    let pageIndicatorBottomPadding: CGFloat
    @Binding var currentIndex: Int
    
    func updateUIView(_ uiView: BPKInternalCarousel, context: Context) {}
    
    func makeUIView(context: Context) -> BPKInternalCarousel {
        let pageIndicator = BPKPageIndicator(
            variant: .overImage,
            currentIndex: $currentIndex,
            totalIndicators: .constant(images.count)
        )
        let pageIndicatorView = UIHostingController(rootView: pageIndicator).view!
        pageIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        pageIndicatorView.backgroundColor = .clear
        let carousel = BPKInternalCarousel(
            pageIndicator: pageIndicatorView,
            pageIndicatorBottomPadding: pageIndicatorBottomPadding
        )
        carousel.delegate = context.coordinator
        
        let uiImages = images.map { UIHostingController(rootView: $0).view! }
        carousel.set(images: uiImages)
        carousel.setCurrentImage(index: currentIndex)
        return carousel
    }

    func makeCoordinator() -> Coordinator {
        Coordinator { index in
            self.currentIndex = index
        }
    }

    class Coordinator: NSObject, BPKInternalCarouselDelegate {
        let onImageIndexChange: (Int) -> Void

        init(onImageIndexChange: @escaping (Int) -> Void) {
            self.onImageIndexChange = onImageIndexChange
        }

        func onImageChange(index: Int) {
            onImageIndexChange(index)
        }
    }
}

struct BPKCarousel_Previews: PreviewProvider {
    
    private static func makeImages() -> [Color] {
        [Color.red, Color.blue, Color.green]
    }
    
    static var previews: some View {
        return VStack {
            BPKCarousel(
                images: makeImages(),
                currentIndex: .constant(0)
            )
            BPKCarousel(
                images: makeImages(),
                currentIndex: .constant(1)
            )
                .frame(height: 150)
            BPKCarousel(
                images: makeImages(),
                currentIndex: .constant(2)
            )
                .frame(width: 150, height: 150)
                .cornerRadius(20)
        }
    }
}

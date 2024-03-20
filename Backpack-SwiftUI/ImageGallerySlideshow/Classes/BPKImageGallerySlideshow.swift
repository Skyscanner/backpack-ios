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

struct ImageGallerySlideshow<ImageView: View>: ViewModifier {
    let images: [BPKImageGalleryImage<ImageView>]
    let closeAccessibilityLabel: String
    let onCloseTapped: () -> Void
    @Binding var currentIndex: Int
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented, content: {
                ContentView(
                    images: images,
                    closeAccessibilityLabel: closeAccessibilityLabel,
                    onCloseTapped: onCloseTapped,
                    currentIndex: $currentIndex
                )
            })
    }
    
    struct ContentView: View {
        let images: [BPKImageGalleryImage<ImageView>]
        let closeAccessibilityLabel: String
        let onCloseTapped: () -> Void
        @Binding var currentIndex: Int
        
        var body: some View {
            GeometryReader { proxy in
                VStack(alignment: .leading, spacing: .xl) {
                    header
                    
                    ZStack(alignment: .bottom) {
                        InternalCarouselWrapper(
                            images: images.map { $0.content() },
                            pageIndicatorVisibility: .hidden,
                            currentIndex: $currentIndex
                        )
                        BPKBadge("\(currentIndex + 1)/\(images.count)")
                            .badgeStyle(.strong)
                            .padding(.bottom, 20)
                    }
                    .frame(width: proxy.size.width, height: proxy.size.width)
                    
                    footer
                }
            }
            .background(Color(.canvasContrastColor))
        }
        
        private var header: some View {
            Button(action: onCloseTapped, label: {
                BPKIconView(.close, size: .large)
                    .foregroundColor(.textPrimaryColor)
                    .padding(.sm)
            })
            .accessibilityLabel(closeAccessibilityLabel)
            .padding(.leading, .base)
        }
        
        private var footer: some View {
            VStack(spacing: .xl) {
                BPKPageIndicator(
                    currentIndex: $currentIndex,
                    totalIndicators: .constant(images.count)
                )
                
                VStack(spacing: .md) {
                    BPKText(descriptionText, style: .caption)
                        .lineLimit(nil)
                    
                    if let credit = images[currentIndex].credit {
                        HStack(spacing: .sm) {
                            BPKIconView(.camera)
                            BPKText(credit, style: .caption)
                        }
                    }
                }
                .accessibilityElement(children: .combine)
                .padding(.horizontal, .lg)
            }
        }
        
        private var descriptionText: String {
            let currentImage = images[currentIndex]
            let titleText = "**\(currentImage.title)**"
            if let description = currentImage.description {
                return "\(titleText). \(description)"
            }
            return currentImage.title
        }
    }
}

public extension View {
    func bpkImageGallerySlideshow<Content>(
        isPresented: Binding<Bool>,
        images: [BPKImageGalleryImage<Content>],
        closeAccessibilityLabel: String,
        currentIndex: Binding<Int>,
        onCloseTapped: @escaping () -> Void
    ) -> some View {
        modifier(
            ImageGallerySlideshow(
                images: images,
                closeAccessibilityLabel: closeAccessibilityLabel,
                onCloseTapped: onCloseTapped,
                currentIndex: currentIndex,
                isPresented: isPresented
            )
        )
    }
}

struct BPKImageGallerySlideshow_Previews: PreviewProvider {
    static var previews: some View {
        ImageGallerySlideshow.ContentView(
            images: [
                BPKImageGalleryImage(title: "Red") {
                    Color.red
                },
                BPKImageGalleryImage(
                    title: "Pumphouse Point",
                    description: "Walk deep into the surrounds of Lake St Clair, world you left behind.",
                    credit: "@PhotographerName"
                ) {
                    Color.yellow
                },
                BPKImageGalleryImage(title: "Green") {
                    Color.green
                }
            ],
            closeAccessibilityLabel: "Close",
            onCloseTapped: {},
            currentIndex: .constant(1)
        )
    }
}

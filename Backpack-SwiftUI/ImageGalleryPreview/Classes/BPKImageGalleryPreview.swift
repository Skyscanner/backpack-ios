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
    public enum Variant {
        case hero(images: [Content], currentIndex: Binding<Int>, onImageClicked: ((Int) -> Void)?)
        case `default`(image: Content, onButtonClicked: (() -> Void)?, buttonText: String)
    }

    private let variant: Variant
    private let images: [Content]
    @Binding private var currentIndex: Int
    private let onImageClicked: ((Int) -> Void)?
    private let buttonText: String?
    
    public init(
        images: [Content],
        currentIndex: Binding<Int>,
        onImageClicked: ((Int) -> Void)? = nil
    ) {
        self.init(variant: .hero(images: images, currentIndex: currentIndex, onImageClicked: onImageClicked))
    }
    
    public init(
        image: Content,
        onButtonClicked: (() -> Void)? = nil,
        buttonText: String
    ) {
        self.init(variant: .default(image: image, onButtonClicked: onButtonClicked, buttonText: buttonText))
    }

    public init(variant: Variant) {
        self.variant = variant
        
        switch variant {
        case let .hero(images, currentIndex, onImageClicked):
            self.images = images
            self._currentIndex = currentIndex
            self.onImageClicked = onImageClicked
            self.buttonText = nil
        case let .default(image, onButtonClicked, buttonText):
            self.images = [image]
            self._currentIndex = .constant(0)
            self.onImageClicked = { _ in onButtonClicked?() }
            self.buttonText = buttonText
        }
    }
    
    public var body: some View {
        Group {
            switch variant {
            case .hero:
                heroView
            case .default:
                defaultView
            }
        }
    }
    
    private var heroView: some View {
        ZStack(alignment: .bottomTrailing) {
            InternalCarouselWrapper(
                images: images,
                pageIndicatorVisibility: .hidden,
                currentIndex: $currentIndex
            )
            .accessibilityHidden(true)
            .if(onImageClicked != nil) { view in
                view.onTapGesture {
                    onImageClicked!(currentIndex)
                }
            }
            BPKPageIndicator(currentIndex: $currentIndex, totalIndicators: .constant(images.count))
                .padding(.bottom, 49)
                .accessibilityAdjustableAction({ direction in
                    switch direction {
                    case .increment: accessibilityPageIncrement()
                    case .decrement: accessibilityPageDecrement()
                    @unknown default:
                        break
                    }
                })
            BPKBadge("\(currentIndex + 1)/\(images.count)")
                .padding(.trailing, 12)
                .padding(.bottom, 44)
                .accessibilityHidden(true)
        }
    }
    
    private var defaultView: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(.canvasContrastColor)
            GeometryReader { geometry in
                images.first
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .if(onImageClicked != nil) { view in
                view.onTapGesture {
                    onImageClicked!(currentIndex)
                }
            }
            if let buttonText {
                BPKButton(
                    buttonText,
                    icon: BPKButton.Icon.init(icon: .picture, position: .leading),
                    action: {
                        onImageClicked?(currentIndex)
                    })
                .buttonStyle(.primaryOnDark)
                .padding(.all, BPKSpacing.base)
            }
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .aspectRatio(1.73, contentMode: .fit)
    }
    
    private func accessibilityPageIncrement() {
        if currentIndex == images.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
    
    private func accessibilityPageDecrement() {
        if currentIndex == 0 {
            currentIndex = images.count - 1
        } else {
            currentIndex -= 1
        }
    }
}

struct BPKImageGalleryPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Self.heroPreview
            Self.defaultPreview
        }
    }
    
    private static var heroPreview: some View {
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
        .previewDisplayName("Hero")
    }
    
    private static var defaultPreview: some View {
        BPKImageGalleryPreview(
            image: Color(BPKColor.coreAccentColor.value),
            onButtonClicked: { print("Clicked image") },
            buttonText: "View Photos"
        )
        .frame(height: 350)
        .padding(.base)
        .previewDisplayName("Default")
    }
    
}

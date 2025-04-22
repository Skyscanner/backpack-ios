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
    private enum Variant {
        case hero
        case inline
    }

    private let variant: Variant
    private let images: [Content]
    @Binding private var currentIndex: Int
    private let onImageClicked: ((Int) -> Void)?
    private let inlineButtonTitle: String?
    
    public init(
        images: [Content],
        currentIndex: Binding<Int>,
        onImageClicked: ((Int) -> Void)? = nil
    ) {
        self.variant = .hero
        self.images = images
        _currentIndex = currentIndex
        self.onImageClicked = onImageClicked
        self.inlineButtonTitle = nil
    }
    
    public init(
        image: Content,
        onImageClicked: ((Int) -> Void)? = nil,
        inlineButtonTitle: String
    ) {
        self.variant = .inline
        self.images = [image]
        self._currentIndex = .constant(0)
        self.onImageClicked = onImageClicked
        self.inlineButtonTitle = inlineButtonTitle
    }
    
    public var body: some View {
        Group {
            switch variant {
            case .hero:
                heroView
            case .inline:
                inlineView
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
    
    private var inlineView: some View {
        ZStack(alignment: .bottomTrailing) {
            GeometryReader { geometry in
                images.first
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
            if let inlineButtonTitle {
                BPKButton(
                    inlineButtonTitle,
                    icon: BPKButton.Icon.init(icon: .picture, position: .leading),
                    action: {})
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
            Self.inlinePreview
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
    
    private static var inlinePreview: some View {
        BPKImageGalleryPreview(
            image: Color(BPKColor.coreAccentColor.value),
            inlineButtonTitle: "View Photos"
        )
        .frame(height: 350)
        .padding(.base)
        .previewDisplayName("Inline")
    }
    
}

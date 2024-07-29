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

public struct BPKCardCarousel<Content: View>: View {
    @Binding private var curentIndex: Int
    private let cards: [Content]
    private let onCardChange: () -> Void
    
    public init(
        cards: [Content],
        curentIndex: Binding<Int>,
        onCardChange: @escaping () -> Void = { }
    ) {
        self.cards = cards
        self._curentIndex = curentIndex
        self.onCardChange = onCardChange
    }
    
    public var body: some View {
        GeometryReader { reader in
            InternalCardCarousel(
                size: reader.size,
                content: cards,
                curentIndex: $curentIndex,
                onCardChange: onCardChange
            )
                .frame(
                    width: reader.size.width,
                    height: reader.size.height)
        }
    }
}

internal struct InternalCardCarousel<Content: View>: View {
    @Binding private var currentIndex: Int
    @State private var currentInternalIndex: Int
    private let onCardChange: () -> Void
    private let content: [Content]
    
    private let size: CGSize
    private let cardCount: Int
    private let cardWidth: CGFloat
    private let dragAnimation: SwiftUI.Animation = .bouncy
    @GestureState private var isDragging: Bool = false
    @GestureState private var totalDrag: CGFloat = 0.0
    
    private var offset: CGFloat {
        return (CGFloat(cardCount) + 1 - CGFloat(currentInternalIndex)) * cardWidth - (cardWidth / 2)
    }
    
    init(
        size: CGSize,
        content: [Content],
        curentIndex: Binding<Int>,
        onCardChange: @escaping () -> Void
    ) {
        self.size = size
        self.cardCount = content.count
        self.cardWidth = size.width * 0.8
        self.content = content + content
        self.onCardChange = onCardChange
        
        currentInternalIndex = cardCount + 1 + curentIndex.wrappedValue
        
        _currentIndex = curentIndex
    }
    
    var body: some View {
        VStack(spacing: .md) {
            LazyHStack(alignment: .center, spacing: 0) {
                ForEach(Array(content.enumerated()), id: \.offset) { index, card in
                    card
                        .frame(width: cardWidth)
                        .offset(x: isDragging ? totalDrag : getContentOffset(
                            for: index,
                            spacing: BPKSpacing.base.value
                        ))
                        .animation(dragAnimation, value: isDragging)
                        .scaleEffect(scaleEffect(for: index))
                }
            }
            .offset(x: offset)
            .gesture(
                DragGesture()
                .updating($totalDrag, body: { value, state, _ in
                    state = value.translation.width
                })
                .updating($isDragging, body: { _, state, _ in
                    state = true
                })
                .onEnded(onDragEnded)
            )
            
            cardIndicator()
        }
    }

    private func scaleEffect(for index: Int) -> CGFloat {
        return currentInternalIndex - 1 == index ? 1 : 0.85
    }
    
    private func getContentOffset (for index: Int, spacing: CGFloat) -> CGFloat {
        if currentInternalIndex - 1 < index {
            return -spacing
        } else if currentInternalIndex - 1 > index {
            return spacing
        }
        return 0
    }

    private func onDragEnded(value: DragGesture.Value) {
        withAnimation(dragAnimation) {
            if value.translation.width < -(cardWidth / 2.0) {
                handleLeftSwipe()
            } else if value.translation.width > (cardWidth / 2.0) {
                handleRightSwipe()
            }
        }
        
        self.currentIndex = (currentInternalIndex - 1) % (cardCount)
    }

    private func handleLeftSwipe() {
        if self.currentInternalIndex == content.count - 1 {
            withAnimation(.none) {
                self.currentInternalIndex = currentInternalIndex % cardCount
            }
        }

        self.currentInternalIndex += 1
        onCardChange()
    }

    private func handleRightSwipe() {
        if currentInternalIndex == 2 {
            withAnimation(.none) {
                self.currentInternalIndex += cardCount
            }
        }
        
        self.currentInternalIndex -= 1
        onCardChange()
    }
    
    private func cardIndicator() -> some View {
        return BPKPageIndicator(
            variant: .default,
            currentIndex: $currentIndex,
            totalIndicators: .constant(cardCount)
        )
    }
}

struct BPKCardCarousel_Previews: PreviewProvider {
    static var previews: some View {
        BPKCardCarousel(
            cards: [
                createCarouselCard,
                createCarouselCard,
                createCarouselCard
            ],
            curentIndex: .constant(0),
            onCardChange: { print("Card Changed") }
        )
    }
    
    static private let createCarouselCard: BPKCarouselCard<AnyView> = BPKCarouselCard(
        content: {
            AnyView(
                Rectangle()
                    .foregroundColor(BPKColor.skyBlue)
            )
        },
        title: "Test Title",
        description: "Test description",
        contentAccessibilityLabel: "Blue rectangle"
    )
}

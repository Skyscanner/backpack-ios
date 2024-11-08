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
    @Binding private var currentIndex: Int
    private let cards: [Content]
    
    public init(
        cards: [Content],
        currentIndex: Binding<Int>
    ) {
        self.cards = cards
        self._currentIndex = currentIndex
    }
    
    public var body: some View {
        GeometryReader { reader in
            InternalCardCarousel(
                size: reader.size,
                content: cards,
                currentIndex: $currentIndex
            )
                .frame(
                    width: reader.size.width,
                    height: reader.size.height
                )
        }
    }
}

internal struct InternalCardCarousel<Content: View>: View {
    private let numberOfCardsForLandscape: CGFloat = 3.0
    @Binding private var currentIndex: Int
    @State private var currentInternalIndex: Int
    @AccessibilityFocusState private var focusOnCard: Int?
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.layoutDirection) var layoutDirection

    private let content: [Content]
    private let size: CGSize
    
    private let cardCount: Int
    private var cardWidth: CGFloat {
        if horizontalSizeClass == .regular {
            size.width / numberOfCardsForLandscape
        } else {
            size.width * 0.8
        }
    }
    private let dragAnimation: Animation = .spring(
        response: 0.5,
        dampingFraction: 0.825,
        blendDuration: 0
    )
    @GestureState private var isDragging: Bool = false
    @GestureState private var totalDrag: CGFloat = 0.0
    
    init(
        size: CGSize,
        content: [Content],
        currentIndex: Binding<Int>
    ) {
        self.size = size
        self._currentIndex = currentIndex
        self.cardCount = content.count
        self._currentInternalIndex = State(initialValue: cardCount + 1 + currentIndex.wrappedValue)
        
        // This is to ensure enough cards to create illusion of
        // infinite scroll
        self.content = content + content
        
        focusOnCard = .init(currentInternalIndex)
    }
    
    var body: some View {
        VStack(spacing: .md) {
            LazyHStack(alignment: .center, spacing: 0) {
                ForEach(Array(content.enumerated()), id: \.offset) { index, card in
                    card
                        .frame(width: cardWidth)
                        .offset(x: isDragging ? totalDrag : getContentOffset(
                            for: index,
                            spacing: horizontalSizeClass == .regular ? 0 : BPKSpacing.base.value
                        ))
                        .animation(dragAnimation, value: totalDrag)
                        .scaleEffect(scaleEffect(for: index))
                        .accessibilityHidden(currentInternalIndex - 1 != index)
                        .accessibilityFocused($focusOnCard, equals: (index + 1))
                }
            }
            .onChange(of: currentIndex, perform: handle(currentIndexChange:))
            .offset(x: offset)
            .gesture(dragGesture)
            
            cardIndicator()
        }
        .if(horizontalSizeClass == .regular, transform: {view in
            view
                .frame(
                    width: cardWidth * numberOfCardsForLandscape
                )
                .clipped()
        })
    }

    private var offset: CGFloat {
        (CGFloat(cardCount) + 1 - CGFloat(currentInternalIndex)) * cardWidth - (cardWidth / 2)
    }
    
    private func handle(currentIndexChange newValue: Int) {
        withAnimation {
            if newValue < currentAdjustedIndex {
                handleRightSwipe()
            } else if newValue > currentAdjustedIndex {
                handleLeftSwipe()
            }
        }
    }
    
    private var currentAdjustedIndex: Int {
        (currentInternalIndex - 1) % (cardCount)
    }

    private var dragGesture: some Gesture {
        DragGesture()
        .updating($totalDrag, body: { value, state, _ in
            if layoutDirection == .leftToRight {
                state = value.translation.width
            } else {
                state = -value.translation.width
            }
        })
        .updating($isDragging, body: { _, state, _ in
            state = true
        })
        .onEnded(onDragEnded)
    }
    
    private func scaleEffect(for index: Int) -> CGFloat {
        currentInternalIndex - 1 == index ? 1 : 0.85
    }
    
    private func getContentOffset(for index: Int, spacing: CGFloat) -> CGFloat {
        if currentInternalIndex - 1 < index {
            -spacing
        } else if currentInternalIndex - 1 > index {
            spacing
        } else {
            0
        }
    }

    private func onDragEnded(value: DragGesture.Value) {
        withAnimation(dragAnimation) {
            let draggingWindow = (cardWidth / 4.0)
            if value.translation.width < -draggingWindow {
                layoutDirection == .leftToRight ? handleLeftSwipe() : handleRightSwipe()
            } else if value.translation.width > draggingWindow {
                layoutDirection == .leftToRight ? handleRightSwipe() : handleLeftSwipe()
            }
        }
    }

    private func updateIndices(with newValue: Int) {
        currentInternalIndex = newValue
        currentIndex = currentAdjustedIndex
        focusOnCard = currentInternalIndex
    }
    
    private func handleLeftSwipe() {
        if currentInternalIndex == content.count - 1 {
            withAnimation(.none) {
                currentInternalIndex = currentInternalIndex % cardCount
            }
        }
        
        updateIndices(with: currentInternalIndex + 1)
    }

    private func handleRightSwipe() {
        if currentInternalIndex == 2 {
            withAnimation(.none) {
                currentInternalIndex += cardCount
            }
        }
        updateIndices(with: currentInternalIndex - 1)
    }
    
    private func cardIndicator() -> some View {
        BPKPageIndicator(
            variant: .default,
            currentIndex: $currentIndex,
            totalIndicators: .constant(cardCount)
        )
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment: handleLeftSwipe()
            case .decrement: handleRightSwipe()
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    BPKCardCarousel(
        cards: Array(0...3).map { _ in
            BPKCarouselCard(
                content: {
                    Rectangle()
                        .foregroundColor(.skyBlue)
                },
                title: "Test Title",
                description: "Test description",
                contentAccessibilityLabel: "Blue rectangle"
            )
        },
        currentIndex: .constant(0)
    )
}

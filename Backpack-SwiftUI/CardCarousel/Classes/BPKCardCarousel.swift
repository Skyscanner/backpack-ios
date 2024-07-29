import SwiftUI

struct BPKCardCarousel<Content: View>: View {
    let cards: [Content]
    let startingIndex: Int
    let onCardChange: () -> Void
    
    init(
        cards: [Content],
        startingIndex: Int = 1,
        onCardChange: @escaping () -> Void = { }
    ) {
        self.cards = cards
        self.startingIndex = startingIndex
        self.onCardChange = onCardChange
    }
    
    var body: some View {
        GeometryReader { reader in
            InternalCardCarousel(
                size: reader.size,
                content: cards,
                startingIndex: startingIndex,
                onCardChange: onCardChange
            )
                .frame(
                    width: reader.size.width,
                    height: reader.size.height)
        }
    }
}

internal struct InternalCardCarousel<Content: View>: View {
    private let size: CGSize
    private let cardCount: Int
    private let cards: [Content]
    private let onCardChange: () -> Void
    
    private let dragAnimation: Animation = Animation.snappy(duration: 0.5)
    private let cardWidth: CGFloat
    
    @State private var currentCardIndex: Int
    @State private var isDragging: Bool = false
    @State private var totalDrag: CGFloat = 0.0
    
    private var offset: CGFloat {
        let normalizedIndex = CGFloat(currentCardIndex) * 0.5
        let cardWidthScale = cardWidth * (1 - normalizedIndex)
        let totalCardWidth = CGFloat(cardCount) * cardWidth
        let avgCardWidth = totalCardWidth / CGFloat(cardCount)
        let currentCardOffset = normalizedIndex * avgCardWidth
        let wierdOffset = (CGFloat(cards.count)) * (CGFloat(cardCount) * 1.8)

        // Calculate final offset
        return cardWidthScale + totalCardWidth - size.width / CGFloat(cardCount) - currentCardOffset - wierdOffset
    }
    
    init(
        size: CGSize,
        content: [Content],
        startingIndex: Int,
        onCardChange: @escaping () -> Void
    ) {
        self.size = size
        self.cardCount = content.count
        self.cardWidth = size.width * 0.8
        self.cards = content + content
        self.onCardChange = onCardChange
        
        currentCardIndex = cardCount + startingIndex
    }
    
    var body: some View {
        VStack(spacing: .md) {
            LazyHStack(alignment: .center, spacing: 0) {
                ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
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
                    .onChanged(onDragChanged)
                    .onEnded(onDragEnded)
            )
            
            cardIndicator()
        }
    }

    private func scaleEffect(for index: Int) -> CGFloat {
        return currentCardIndex - 1 == index ? 1 : 0.85
    }
    
    private func getContentOffset (for index: Int, spacing: CGFloat) -> CGFloat {
        if currentCardIndex - 1 < index {
            return -spacing
        } else if currentCardIndex - 1 > index {
            return spacing
        }
        return 0
    }

    private func onDragChanged (value: DragGesture.Value) {
        totalDrag = value.translation.width
        isDragging = true
    }

    private func onDragEnded(value: DragGesture.Value) {
        totalDrag = 0.0
        isDragging = false
        
        withAnimation(dragAnimation) {
            if value.translation.width < -(cardWidth / 2.0) {
                handleLeftSwipe()
            } else if value.translation.width > (cardWidth / 2.0) {
                handleRightSwipe()
            }
        }
    }

    private func handleLeftSwipe() {
        if self.currentCardIndex == cards.count - 1 {
            withAnimation(.none) {
                self.currentCardIndex = currentCardIndex % cardCount
            }
        }

        self.currentCardIndex += 1
        onCardChange()
    }

    private func handleRightSwipe() {
        if currentCardIndex == 2 {
            withAnimation(.none) {
                self.currentCardIndex += cardCount
            }
        }
        
        self.currentCardIndex -= 1
        onCardChange()
    }
    
    private func cardIndicator() -> some View {
        return HStack(spacing: .md) {
            ForEach(0..<cardCount, id: \.self) { index in
                Circle()
                    .fill((index == (currentCardIndex - 1) % cardCount) ?
                        Color(.darkGray) :
                        Color(.lightGray)
                    )
                    .frame(width: 10, height: 10)
                    .animation(.linear(duration: 0.3), value: currentCardIndex)
            }
        }.padding([.top, .bottom], .base)
    }
}

struct BPKCardCarousel_Previews: PreviewProvider {
    static var previews: some View {
        BPKCardCarousel(
            cards: [
                createCarouselCard,
                createCarouselCard,
//                createCarouselCard,
                createCarouselCard
            ],
            startingIndex: 1,
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

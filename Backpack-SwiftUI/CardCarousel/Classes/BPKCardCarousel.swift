import SwiftUI
import Backpack_Common

struct CardCarousel<Content: View>: View {
    @State var currentIndex: Int
    let carouselCards: [BPKCarouselCard<Content>]
    
    init(startingIndex currentIndex: Int = 0, carouselCards: [BPKCarouselCard<Content>]) {
        self.currentIndex = currentIndex
        self.carouselCards = carouselCards
    }
    
    var body: some View {
        VStack {
            InternalCardCarouselWrapper(
                currentIndex: $currentIndex,
                cards: carouselCards
            )
            
            // Circle indication for selected index
            HStack(spacing: 8) {
                ForEach(0..<carouselCards.count, id: \.self) { index in
                    Circle()
                        .fill((index == currentIndex) ? Color.init(.darkGray) : Color.init(.lightGray))
                        .frame(width: 10, height: 10)
                        .animation(.linear(duration: 0.3), value: currentIndex)
                }
            }
            .padding([.bottom, .top], 10)
        }
    }
}

struct InternalCardCarouselWrapper: UIViewControllerRepresentable {
    @Binding var currentIndex: Int
    let cards: [any View]
    
    func makeUIViewController(context: Context) -> UIViewController {
        return BPKInternalCardCarousel(
            cards: cards,
            currentIndex: $currentIndex
        )
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}

#Preview {
    CardCarousel(
        startingIndex: 0,
        carouselCards: [
            BPKCarouselCard(
                content: {
                    Rectangle()
                        .foregroundColor(BPKColor.skyBlue)
                },
                title: "Card 1",
                desctiption: "Card 1 description"
            ),
            BPKCarouselCard(
                content: {
                    Rectangle()
                        .foregroundColor(BPKColor.corePrimaryColor)
                },
                title: "Card 2",
                desctiption: "Card 2 description"
            ),
            BPKCarouselCard(
                content: {
                    Rectangle()
                        .foregroundColor(BPKColor.coreEcoColor)
                },
                title: "Card 3",
                desctiption: "Card 3 description"
            )
        ]
    )
}

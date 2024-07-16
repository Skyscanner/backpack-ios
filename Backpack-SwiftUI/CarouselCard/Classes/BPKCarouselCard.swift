import SwiftUI

public struct BPKCarouselCard<Content: View>: View {
    @ViewBuilder let content: () -> Content
    let title: String
    let desctiption: String
    let imageAccessibilityLabel: String
    
    public init(
        content: @escaping () -> Content,
        title: String,
        desctiption: String,
        imageAccessibilityLabel: String
    ) {
        self.content = content
        self.title = title
        self.desctiption = desctiption
        self.imageAccessibilityLabel = imageAccessibilityLabel
    }
    
    public var body: some View {
        GeometryReader { reader in
            BPKCard(padding: .none, cornerStyle: .large, elevation: .focus, content: {
                VStack(alignment: .leading) {
                    content()
                        .frame(
                            width: reader.size.width,
                            height: reader.size.height * 0.65
                        )
                        .accessibilityLabel(imageAccessibilityLabel)
                        .clipped()
                    
                    VStack(alignment: .leading) {
                        BPKText("\(title)", style: .heading2)
                            .padding(.bottom, 5)
                        
                        BPKText("\(desctiption)", style: .bodyLongform)
                    }.padding(.all, .lg)
                    
                    Spacer()
                }
            })
            .disabled(true)
        }
    }
}

#Preview {
    BPKCarouselCard(
        content: {
            Rectangle()
                .foregroundColor(BPKColor.skyBlue)
        },
        title: "Test Title",
        desctiption: "Test description",
        imageAccessibilityLabel: "Blue rectangle"
    )
    .padding()
}

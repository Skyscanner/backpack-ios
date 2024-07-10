import SwiftUI

struct BPKCarouselCard<Content: View>: View {
    @ViewBuilder let content: () -> Content
    let title: String
    let desctiption: String
    
    let accessibilityIdentifier: String = ""
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .overlay(content: {
                        CardContent(
                            content: { content() },
                            reader: reader,
                            title: title,
                            desctiption: desctiption
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    })
            }
        }
    }
}

struct CardContent<Content: View>: View {
    @ViewBuilder var content: () -> Content
    var reader: GeometryProxy
    let title: String
    let desctiption: String
    
    var body: some View {
        VStack {
            content()
                .frame(width: reader.size.width, height: reader.size.height * 0.65)
                .clipped()
            
            HStack {
                VStack(alignment: .leading) {
                    BPKText("\(title)", style: .heading2)
                        .padding(.bottom, 5)
                    
                    BPKText("\(desctiption)", style: .bodyLongform)
                }.padding(.all, .lg)
                
                Spacer()
            }
            Spacer()
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
        desctiption: "Test description"
    ).padding()
}

import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKCarouselFigmaConnect<Content: View>: FigmaConnect {
    let component = Backpack_SwiftUI.BPKCarousel<Content>.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-50288"

    var body: some View {
        Backpack_SwiftUI.BPKCarousel(
            images: [
                Color.red,
                Color.blue,
                Color.green
            ],
            currentIndex: .constant(0)
        )
        .frame(height: 200)
    }
}

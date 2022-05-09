import SwiftUI
import Backpack_Common

public struct BPKIconView: View {
    @State var icon: BPKIcon
    @State var size: BPKIcon.Size
    
    public init(_ icon: BPKIcon, size: BPKIcon.Size = .small) {
        self.icon = icon
        self.size = size
    }

    public var body: some View {
        Image(icon: icon)
            .frame(width: size.frame.width, height: size.frame.height)
    }
}

private extension BPKIcon.Size {
    var frame: CGSize {
        switch self {
        case .large:
            return .init(width: 24, height: 24)
        case .small:
            return .init(width: 16, height: 16)
        }
    }
}


private extension Image {
    init(icon: BPKIcon, size: BPKIcon.Size = .small) {
        self.init(icon.name, bundle: BPKCommonBundle.iconsBundle)
    }
}


struct BPKIconView_Previews: PreviewProvider {
    static var previews: some View {
        BPKIconView(.account, size: .large)
    }
}

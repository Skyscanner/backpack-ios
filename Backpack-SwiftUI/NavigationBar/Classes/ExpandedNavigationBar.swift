import SwiftUI

struct ExpandedNavigationBar: View {
    let title: String?
    let style: BPKNavigationBarStyle
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color(style.backgroundColor(expanded: true))
                .frame(height: style.expandedNavigationBarHeight)
            BPKText(title ?? "", style: .heading2)
                .foregroundColor(style.foregroundColor(expanded: true))
                .padding(.top, -style.largeTitlePadding)
                .frame(height: style.expandedNavigationBarHeight)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, .base)
        }
    }
}

struct ExpandedNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExpandedNavigationBar(
                title: "Hotels",
                style: .default
            )
            ExpandedNavigationBar(
                title: "Hotels",
                style: .transparent
            )
        }
        .frame(maxHeight: .infinity)
        .background(.red)
    }
}

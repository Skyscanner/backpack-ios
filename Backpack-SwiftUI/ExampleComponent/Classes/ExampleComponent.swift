import SwiftUI

public struct ExampleComponent: View {
    @State var content: String

    public var body: some View {
        Text(content)
    }
}

struct ExampleComponent_Previews: PreviewProvider {
    static var previews: some View {
        ExampleComponent(content: "Testing!")
    }
}

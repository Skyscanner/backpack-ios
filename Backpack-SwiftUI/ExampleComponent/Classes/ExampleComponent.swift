import SwiftUI

public struct ExampleComponent: View {
    @State var content: String

    public var body: some View {
        Text(content)
    }
}
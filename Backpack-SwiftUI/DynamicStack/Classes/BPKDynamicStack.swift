import SwiftUI
import Backpack_Common

public struct BPKDynamicStack<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    private let horizontalAlignment: HorizontalAlignment
    private let verticalAlignment: VerticalAlignment
    private let spacing: BPKSpacing
    private let threshold: DynamicTypeSize
    private let content: Content

    public init(
        horizontalAlignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center,
        spacing: BPKSpacing = .none,
        threshold: DynamicTypeSize = .accessibility1,
        @ViewBuilder content: () -> Content
    ) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.threshold = threshold
        self.content = content()
    }

    public var body: some View {
        if dynamicTypeSize >= threshold {
            VStack(
                alignment: horizontalAlignment,
                spacing: spacing
            ) {
                content
            }
        } else {
            HStack(
                alignment: verticalAlignment,
                spacing: spacing
            ) {
                content
            }
        }
    }
}

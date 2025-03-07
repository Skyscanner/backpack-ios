import SwiftUI
import Backpack_Common

public struct BPKDynamicStack<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    private let threshold: DynamicTypeSize
    private let primaryLayout: AnyLayout
    private let secondaryLayout: AnyLayout
    private let content: Content

    public init(
        threshold: DynamicTypeSize = .accessibility1,
        primaryLayout: AnyLayout = AnyLayout(HStackLayout()),
        secondaryLayout: AnyLayout = AnyLayout(VStackLayout()),
        @ViewBuilder content: () -> Content
    ) {
        self.threshold = threshold
        self.primaryLayout = primaryLayout
        self.secondaryLayout = secondaryLayout
        self.content = content()
    }

    public init(
        horizontalAlignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center,
        spacing: BPKSpacing = .none,
        threshold: DynamicTypeSize = .accessibility1,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            threshold: threshold,
            primaryLayout: AnyLayout(HStackLayout(alignment: verticalAlignment, spacing: spacing.value)),
            secondaryLayout: AnyLayout(VStackLayout(alignment: horizontalAlignment, spacing: spacing.value)),
            content: content
        )
    }

    public var body: some View {
        let layout = dynamicTypeSize >= threshold ? secondaryLayout : primaryLayout

        layout {
            content
        }
    }
}

import SwiftUI

public extension InsettableShape {
    func strokeBorder(
        _ color: BPKColor,
        lineWidth: CGFloat = 1,
        antialiased: Bool = true) -> some View {
            strokeBorder(Color(color.value), lineWidth: lineWidth, antialiased: antialiased)
        }
}

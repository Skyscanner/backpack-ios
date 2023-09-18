import SwiftUI

public struct BPKTextEditor: View {
    
    private enum TextEditorConstants {
        static let verticalPadding: BPKSpacing = .sm
        static let horizontalPadding: CGFloat = 12
    }

    private enum PlaceholderConstants {
        static let verticalPadding: CGFloat = 12
        static let horizontalPadding: BPKSpacing = .base
    }

    private enum BorderConstants {
        static let cornerRadius: BPKCornerRadius = .xs
        static let lineWidth: CGFloat = 1
    }
    
    @Binding private var text: String
    private let charLimit: Int
    private let placeholder: String

    /// Creates a `BPKTextEditor`.
    ///
    /// - Parameters:
    ///   - placeholder: The placeholder text to display when the text field is empty.
    ///   - charLimit: Limit of character allowed to enter
    ///   - text: The text to display in the text field.
    public init(
        _ text: Binding<String>,
        placeholder: String = "",
        charLimit: Int
    ) {
        
        self._text = text
        self.placeholder = placeholder
        self.charLimit = charLimit
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Text editor
            TextEditor(text: $text)
                .font(style: .bodyDefault)
                .foregroundColor(.textPrimaryColor)
                .padding(.vertical, TextEditorConstants.verticalPadding)
                .padding(.horizontal, TextEditorConstants.horizontalPadding)
                .onChange(of: text) { _ in
                    if text.count > charLimit {
                        text = String(text.prefix(charLimit))
                    }
                }
            
            // Placeholder
            BPKText(placeholder, style: .bodyDefault)
                .foregroundColor(.textSecondaryColor)
                .allowsHitTesting(false)
                .padding(.vertical, PlaceholderConstants.verticalPadding)
                .padding(.horizontal, PlaceholderConstants.horizontalPadding)
                .opacity(text.isEmpty ? 1 : 0)
            
            // Border
            RoundedRectangle(cornerRadius: BorderConstants.cornerRadius)
                .strokeBorder(.lineColor, lineWidth: BorderConstants.lineWidth)
        }
        .background(.surfaceDefaultColor)
        .clipShape(
            RoundedRectangle(cornerRadius: BorderConstants.cornerRadius)
        )
    }
    
}

fileprivate extension TextEditor {
    func font(style: BPKFontStyle) -> some View {
        self.font(style.font)
    }
}

struct BPKTextEditor_Previews: PreviewProvider {
    @State static var text: String = "please work"
    static var previews: some View {
        BPKTextEditor($text, charLimit: 1000).frame(height: 200)
            .padding()
    }
}

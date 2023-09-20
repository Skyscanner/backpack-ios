import SwiftUI
import UIKit

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
    
    @Environment(\.colorScheme) var colorScheme
    @Binding private var text: String
    private let charLimit: Int
    private let placeholder: String
    
    /// Creates a `BPKTextEditor`.
    ///
    /// - Parameters:
    ///   - text: The text to display in the text field.
    ///   - placeholder: The placeholder text to display when the text field is empty.
    ///   - charLimit: Limit of character allowed to enter
    public init(
        _ text: Binding<String>,
        placeholder: String = "",
        charLimit: Int
    ) {
        self._text = text
        self.placeholder = placeholder
        self.charLimit = charLimit
    }
    
//    var backgroundColor: BPKColor {
//        if #unavailable(iOS 16.0), colorScheme == .dark {
//            return .clear
//        }
//        return .surfaceDefaultColor
//    }
    
    @ViewBuilder
    var textEditorContent: some View {
        UITextViewRepresentable(text: $text, charLimit: charLimit)
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Text editor
            textEditorContent
                .foregroundColor(.textPrimaryColor)
                .padding(.vertical, TextEditorConstants.verticalPadding)
                .padding(.horizontal, TextEditorConstants.horizontalPadding)
                .onChange(of: text) { newValue in
                    if newValue.count > charLimit {
                        text = String(newValue.prefix(charLimit))
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
        //        .background(backgroundColor)
        .clipShape(
            RoundedRectangle(cornerRadius: BorderConstants.cornerRadius)
        )
        .accessibilityLabel(placeholder)
    }
    
}

fileprivate extension TextEditor {
    func font(style: BPKFontStyle) -> some View {
        self.font(style.font)
    }
}

struct BPKTextEditor_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        BPKTextEditor($text, placeholder: "Enter your text", charLimit: 1000).frame(height: 200)
            .padding()
    }
}

// TEMP: Suggestion for using UIViewRepresentable to style UITextView
struct UITextViewRepresentable: UIViewRepresentable {
    @Binding var text: String
    let charLimit: Int
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.text = text
        textView.font = UIFont.init(descriptor: .init(name: BPKRelativeFontDefinition().fontFamily, size: 16), size: 16)
        textView.adjustsFontForContentSizeCategory = false
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if text.count > charLimit {
            uiView.text = String(text.prefix(charLimit))
        }
    }
    typealias UIViewType = UITextView
}

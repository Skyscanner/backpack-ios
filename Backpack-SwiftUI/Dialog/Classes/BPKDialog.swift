/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SwiftUI

struct SuccessDialogView: ViewModifier {
    enum Header {
        case image(name: String)
        case icon(BPKIcon, BPKColor)
    }
    
    @Binding var isPresented: Bool
    let contentAlignment: HorizontalAlignment
    let buttons: [BPKDialogButton]
    let header: Header?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            ZStack {
                if isPresented {
                    ZStack {
                        Color(BPKColor.scrimColor)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .onTapGesture {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        HStack {
                            Spacer(minLength: .lg)
                            VStack(spacing: 0) {
                                if case let .icon(icon, color) = header {
                                    iconHeader(icon, color)
                                }
                                VStack(spacing: 0) {
                                    //                            Image("dialog_image").resizable().scaledToFill().frame(maxHeight: 200).clipped()
                                    VStack(spacing: BPKSpacing.lg.value) {
                                        dialogContentView
                                        actionsView
                                    }
                                }
                                .padding(.lg)
                                .padding(.top, 12)
                                .background(.surfaceDefaultColor)
                                .clipShape(RoundedRectangle(cornerRadius: .md))
                                .shadow(.lg)
                            }
                            
                            Spacer(minLength: .lg)
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                                                .zIndex(1)
                        .frame(maxWidth: 400)
                    }
                }
            }
        }
    }
    
    private func iconHeader(_ icon: BPKIcon, _ color: BPKColor) -> some View {
        ZStack {
            Color(color)
                .clipShape(Circle())
                .padding(4)
            BPKIconView(icon, size: .large)
                .colorInvert()
        }
        .zIndex(2)
        .frame(width: 64, height: 64)
        .background(.surfaceDefaultColor)
        .clipShape(Circle())
        .padding(.bottom, -30)
    }
    
    private var dialogContentView: some View {
        VStack(alignment: contentAlignment, spacing: BPKSpacing.md.value) {
            BPKText("Title in here", style: .heading3)
            BPKText("Description that goes two lines ideally, but sometimes it can go longer")
                .lineLimit(nil)
                .multilineTextAlignment(contentAlignment.textAlignment)
            
        }
    }
    
    private var actionsView: some View {
        VStack(spacing: BPKSpacing.md.value) {
            ForEach(buttons, id: \.title) { button in
                BPKButton(button.title, size: .large, action: button.action)
                    .buttonStyle(button.style)
                    .stretchable()
            }
        }
    }
}

fileprivate extension HorizontalAlignment {
    var textAlignment: TextAlignment {
        switch self {
        case .leading: return .leading
        case .center: return .center
        case .trailing: return .trailing
        default: return .leading
        }
    }
}

enum BPKDialogType {
    case success, warning, destructive, flare, image
}

public struct BPKDialogButton {
    let title: String
    let action: () -> Void
    let style: BPKButton.Style
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        style = .secondary
    }
    
    init(button: BPKDialogButton, style: BPKButton.Style) {
        title = button.title
        action = button.action
        self.style = style
    }
}

public extension View {
    func bpkSuccessDialog(
        presented: Binding<Bool>,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryButton: BPKDialogButton? = nil,
        linkButton: BPKDialogButton? = nil,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryButton {
            buttons.append(BPKDialogButton(button: secondaryButton, style: .secondary))
        }
        if let linkButton {
            buttons.append(BPKDialogButton(button: linkButton, style: .link))
        }
        return self.modifier(SuccessDialogView(isPresented: presented, contentAlignment: .center, buttons: buttons, header: .icon(.tick, .coreAccentColor)))
    }
    
    func bpkWarningDialog(
        presented: Binding<Bool>,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryButton: BPKDialogButton? = nil,
        linkButton: BPKDialogButton? = nil,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryButton {
            buttons.append(BPKDialogButton(button: secondaryButton, style: .secondary))
        }
        if let linkButton {
            buttons.append(BPKDialogButton(button: linkButton, style: .link))
        }
        return self.modifier(SuccessDialogView(isPresented: presented, contentAlignment: .center, buttons: buttons, header: .icon(.alertAdd, .statusWarningSpotColor)))
    }
    
    func bpkDestructiveDialog(
        presented: Binding<Bool>,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        linkButton: BPKDialogButton? = nil,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .destructive)]
        if let linkButton {
            buttons.append(BPKDialogButton(button: linkButton, style: .link))
        }
        return self.modifier(SuccessDialogView(isPresented: presented, contentAlignment: .center, buttons: buttons, header: .icon(.trash, .statusDangerSpotColor)))
    }
    
    func bpkImageDialog(
        presented: Binding<Bool>,
        title: String,
        text: String,
        confirmButton: BPKDialogButton,
        secondaryButton: BPKDialogButton? = nil,
        linkButton: BPKDialogButton? = nil,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        var buttons = [BPKDialogButton(button: confirmButton, style: .featured)]
        if let secondaryButton {
            buttons.append(BPKDialogButton(button: secondaryButton, style: .secondary))
        }
        if let linkButton {
            buttons.append(BPKDialogButton(button: linkButton, style: .link))
        }
        return self.modifier(SuccessDialogView(isPresented: presented, contentAlignment: .center, buttons: buttons, header: .icon(.alertAdd, .statusWarningSpotColor)))
    }
}

struct BPKFlare<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .clipShape(FlareShape(roundedCorner: .lg))
    }
}

struct FlareShape: Shape {
    let roundedCorner: BPKCornerRadius
    
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            let offsetRect = CGRect(origin: rect.origin, size: CGSize(width: rect.width, height: rect.height - 16))
//            path.addRoundedRect(in: offsetRect, cornerSize: CGSize(width: roundedCorner.value, height: roundedCorner.value))
            path.move(to: CGPoint(x: (offsetRect.width / 2) + 40, y: offsetRect.height))
//            path.addEllipse(in: .init(origin: CGPoint(x: (offsetRect.width / 2) + 40, y: offsetRect.height), size: .init(width: 3, height: 3)))
            path.addCurve(
                to: CGPoint(x: (offsetRect.width / 2), y: rect.height), control1: CGPoint(x: (offsetRect.width / 2) - 40, y: offsetRect.height), control2: CGPoint(x: (offsetRect.width / 2) + 40, y: offsetRect.height))
//            path.addLine(to: CGPoint(x: (offsetRect.width / 2) - 40, y: offsetRect.height))
        }
    }
}

struct BPKDialog_Previews: PreviewProvider {
    static var previews: some View {
//        Text("Hello, World!")
//            .bpkDestructiveDialog(
//                presented: .constant(true),
//                title: "Title in here",
//                text: "Description that goes two lines ideally, but sometimes it can go longer",
//                confirmButton: .init(title: "Delete", action: {}),
////                secondaryButton: .init(title: "Skip", action: {}),
//                linkButton: .init(title: "Cancel", action: {})
//            )
        BPKFlare {
            Rectangle()
                .fill(.red)
                .frame(width: 200, height: 200)
        }
    }
}

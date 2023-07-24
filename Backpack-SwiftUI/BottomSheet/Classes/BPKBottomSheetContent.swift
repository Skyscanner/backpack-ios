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

public struct BPKBottomSheetAction {
    var title: String
    var action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

struct BPKBottomSheetContent<BottomSheetContent: View>: View {
    @Binding var isPresented: Bool
    
    let isClosable: Bool
    let closeButtonAccessibilityLabel: String?
    let title: String?
    let contentMode: BPKBottomSheetContentMode
    let action: BPKBottomSheetAction?
    
    @ViewBuilder let content: BottomSheetContent
    
    init(
        isPresented: Binding<Bool>,
        isClosable: Bool,
        closeButtonAccessibilityLabel: String? = nil,
        title: String? = nil,
        contentMode: BPKBottomSheetContentMode = .regular,
        action: BPKBottomSheetAction? = nil,
        @ViewBuilder content: () -> BottomSheetContent
    ) {
        self._isPresented = isPresented
        self.isClosable = isClosable
        self.closeButtonAccessibilityLabel = closeButtonAccessibilityLabel
        self.title = title
        self.contentMode = contentMode
        self.action = action
        self.content = content()
    }
    
    private var isFullSize: Bool {
        contentMode == .fullSize
    }
    
    private var header: some View {
        HStack {
            if isClosable {
                BPKButton(
                    icon: .close,
                    accessibilityLabel: closeButtonAccessibilityLabel ?? "") {
                        isPresented.toggle()
                    }
                    .buttonStyle(.link)
            }
            Spacer()
            if let title = title {
                BPKText(title, style: .heading5)
            }
            Spacer()
            if let action = action {
                BPKButton(action.title, action: action.action)
                    .buttonStyle(.link)
            }
        }
        .padding(.vertical, .md)
        .padding(.horizontal, .base)
    }
    
    var body: some View {
        VStack {
            if !isFullSize {
                header
            }
            content
        }
        .background(.canvasColor)
    }
}

struct BPKBottomSheetRegular_Previews: PreviewProvider {
    static var previews: some View {
        BPKBottomSheetContent(
            isPresented: .constant(true),
            isClosable: true,
            title: "Title",
            action: BPKBottomSheetAction(title: "Action", action: {})
        ) {
            BPKText("Bottom sheet content")
        }
    }
}

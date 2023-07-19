/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

struct CustomPickerStyle: ViewModifier {
    var labelText: String
    var width: CGFloat
    
    func body(content: Content) -> some View {
        Menu {
            content
        } label: {
            HStack {
                if let labelText = labelText {
                    BPKText(labelText)
                    Spacer()
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .frame(width: 12, height: 8)
                        .rotationEffect(.degrees(180))
                }
            }
        }
        .padding(.md)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .sm))
//        .outline(.black, cornerRadius: .sm)
        .frame(maxWidth: width, alignment: .leading)
    }
}

extension View {
    func customPickerStyle(labelText: String, width: CGFloat) -> some View {
        self.modifier(CustomPickerStyle(labelText: labelText, width: width))
    }
}

public struct BPKSelect: View {
    
    @State private var selection: String
    private let options: [String]
    //    private var state: BPKFieldSet.State = .default
    
    public init(
        options: [String]
    ) {
        self.options = options
        if let selectedText = options.first {
            self.selection = selectedText
        } else {
            self.selection = "Default"
        }
    }
    
    public var body: some View {
        VStack {
            
            Picker("Flavor", selection: $selection) {
                ForEach(options, id: \.self) { t in
                    Text(t)
                }
            }
            .customPickerStyle(
                labelText: selection,
                width: .infinity)
        }
    }
}

struct BPKSelect_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKSelect(
                options: ["What", "will", "You choose for breakfast?"]
            )
        }
        .padding()
        .background(.coreEcoColor)
    }
}

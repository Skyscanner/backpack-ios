/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2024 Skyscanner Ltd
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

public struct BPKCarouselCard<Content: View>: View {
    @ViewBuilder let content: () -> Content
    let title: String
    let description: String
    let imageAccessibilityLabel: String
    
    public init(
        content: @escaping () -> Content,
        title: String,
        description: String,
        imageAccessibilityLabel: String
    ) {
        self.content = content
        self.title = title
        self.description = description
        self.imageAccessibilityLabel = imageAccessibilityLabel
    }
    
    public var body: some View {
        GeometryReader { reader in
            BPKCard(padding: .none, cornerStyle: .large, elevation: .focus, content: {
                VStack(alignment: .leading) {
                    content()
                        .frame(
                            width: reader.size.width,
                            height: reader.size.height * 0.71
                        )
                        .accessibilityLabel(imageAccessibilityLabel)
                        .clipped()
                    
                    VStack(alignment: .leading) {
                        BPKText(title, style: .heading3)
                            .padding(.bottom, .md)
                            .lineLimit(nil)
                        
                        BPKText(description, style: .bodyDefault)
                            .lineLimit(nil)
                    }.padding(.all, .lg)
                    
                    Spacer()
                }
            })
            .frame(minHeight: 530)
            .disabled(true)
        }
    }
}

struct BPKCarouselCard_Previews: PreviewProvider {
    static var previews: some View {
        BPKCarouselCard(
            content: {
                Rectangle()
                    .foregroundColor(BPKColor.skyBlue)
            },
            title: "Test Title",
            description: "Test description",
            imageAccessibilityLabel: "Blue rectangle"
        )
        .padding()
    }
}

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
    private let title: String
    private let description: String
    private let contentAccessibilityLabel: String
    private var getAccessibilityLabel: String {
        return "\(contentAccessibilityLabel) \(title) \(description)"
    }
    
    public init(
        content: @escaping () -> Content,
        title: String,
        description: String,
        contentAccessibilityLabel: String
    ) {
        self.content = content
        self.title = title
        self.description = description
        self.contentAccessibilityLabel = contentAccessibilityLabel
    }
    
    public var body: some View {
        GeometryReader { reader in
            Group {
                if #available(iOS 16.4, *) {
                    ScrollView {
                        cardContent(reader: reader)
                    }
                    .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
                } else {
                    ScrollView {
                        cardContent(reader: reader)
                    }
                    .onAppear(perform: {
                        UIScrollView.appearance().bounces = false
                    })
                    .onDisappear(perform: {
                        UIScrollView.appearance().bounces = true
                    })
                }
            }
            .background(.white.darkVariant(.badgeBackgroundNormalColor))
            .clipShape(RoundedRectangle(cornerRadius: .md))
            .shadow(.lg)
        }
    }
    
    private func cardContent(reader: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: BPKSpacing.none) {
            content()
                .frame(
                    width: reader.size.width,
                    height: reader.size.height * 0.60
                )
                .clipped()
            
            VStack(alignment: .leading, spacing: BPKSpacing.none) {
                BPKText(title, style: .heading3)
                    .lineLimit(nil)
                    .padding(.bottom, .md)
                
                BPKText(description, style: .bodyDefault)
                    .lineLimit(nil)
            }
            .padding(.all, .lg)
            
            Spacer()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(getAccessibilityLabel)
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
            contentAccessibilityLabel: "Blue rectangle"
        )
        .padding()
    }
}

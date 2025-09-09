/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

public struct BPKSnippet: View {
    let image: Image
    let headline: String?
    let subheading: String?
    let bodyText: String?
    let imageOrientation: ImageOrientation
    let onClick: (() -> Void)?
    
    public init(
        image: Image,
        headline: String? = nil,
        subheading: String? = nil,
        bodyText: String? = nil,
        imageOrientation: ImageOrientation = .landscape,
        onClick: (() -> Void)? = nil
    ) {
        self.image = image
        self.headline = headline
        self.subheading = subheading
        self.bodyText = bodyText
        self.imageOrientation = imageOrientation
        self.onClick = onClick
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            imageView

            if let headline {
                BPKText(headline, style: .heading5)
                    .lineLimit(nil)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.top, .base)
            }
            if let subheading {
                BPKText(subheading, style: .subheading)
                    .lineLimit(nil)
                    .padding(.top, headline != nil ? .sm : .base)
            }
            if let bodyText {
                let topPadding: CGFloat = {
                    if subheading != nil { return BPKSpacing.xl.value }
                    if headline != nil { return BPKSpacing.sm.value }
                    return BPKSpacing.base.value
                }()
                BPKText(bodyText, style: .bodyDefault)
                    .lineLimit(nil)
                    .padding(.top, topPadding)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .onTapGesture {
            onClick?()
        }
    }

    private var imageView: some View {
        GeometryReader { geo in
            image
                .resizable()
                .scaledToFill()
                .background(.surfaceHighlightColor)
                .frame(width: geo.size.width)
        }
        .aspectRatio(aspectRatio(for: imageOrientation), contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: .md, style: .continuous))
    }
    
    private func aspectRatio(for imageOrientation: ImageOrientation) -> CGFloat {
        switch imageOrientation {
        case .landscape:
            return 3/2
        case .square:
            return 1
        case .portrait:
            return 5/7
        }
    }
}

struct BPKSnippet_Previews: PreviewProvider {
    static var previews: some View {
        BPKSnippet(
            image: Image("dialog_image"),
            headline: "Headline Text?",
            subheading: "Description",
            bodyText: "Body Text"
        )
        .padding()
    }
}

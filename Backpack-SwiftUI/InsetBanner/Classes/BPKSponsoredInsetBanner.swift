//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

/// A sponsored inset banner view with mandatory logo and sponsored label
/// and optional title, subheadline, and image content.
public struct BPKSponsoredInsetBanner<LogoContent: View, ImageContent: View>: View {
    private let logo: LogoContent
    private let sponsoredLabel: String
    private let sponsoredAccessibilityHint: String?
    private let onSponsoredLabelTapped: () -> Void
    private let title: String?
    private let subheadline: String?
    private let image: ImageContent?
    
    /// Initialize a BPKSponsoredInsetBanner with all optional content
    ///
    /// - Parameters:
    ///   - logo: The logo content to display (mandatory)
    ///   - sponsoredLabel: The sponsored label text (required)
    ///   - onSponsoredLabelTapped: Action to perform when tapping the sponsored label
    ///   - sponsoredAccessibilityHint: Optional accessibility hint for the sponsored label
    ///   - title: Optional title text
    ///   - subheadline: Optional subheadline text
    ///   - image: Optional image content
    public init(
        logo: LogoContent,
        sponsoredLabel: String,
        onSponsoredLabelTapped: @escaping () -> Void,
        sponsoredAccessibilityHint: String? = nil,
        title: String? = nil,
        subheadline: String? = nil,
        image: ImageContent? = nil
    ) {
        self.logo = logo
        self.sponsoredLabel = sponsoredLabel
        self.sponsoredAccessibilityHint = sponsoredAccessibilityHint
        self.onSponsoredLabelTapped = onSponsoredLabelTapped
        self.title = title
        self.subheadline = subheadline
        self.image = image
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            topView
            imageView
        }
        .background(
            RoundedRectangle(cornerRadius: .sm, style: .continuous)
                .foregroundColor(.sponsoredBannerBackgroundColor)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: .sm, style: .continuous)
        )
    }
    
    private var topView: some View {
        HStack(spacing: .md) {
            logo
                .frame(maxWidth: Constants.maxLogoWidth, maxHeight: Constants.maxLogoHeight)
                .fixedSize(horizontal: true, vertical: false)
            
            titlesView
            
            Spacer()
            
            sponsoredButton
        }
        .padding(.base)
    }
    
    @ViewBuilder
    private var titlesView: some View {
        if title != nil || subheadline != nil {
            VStack(alignment: .leading, spacing: .sm) {
                if let title = title {
                    BPKText(title, style: .label2)
                        .foregroundColor(.textPrimaryColor)
                        .lineLimit(nil)
                }
                if let subheadline = subheadline {
                    BPKText(subheadline, style: .caption)
                        .foregroundColor(.textPrimaryColor)
                        .lineLimit(nil)
                }
            }
        }
    }
    
    private var sponsoredButton: some View {
        Button(action: onSponsoredLabelTapped) {
            HStack(spacing: .sm) {
                BPKText(sponsoredLabel, style: .caption)
                    .foregroundColor(.textLinkColor)
                    .lineLimit(nil)
                
                BPKIconView(.informationCircle)
                    .foregroundColor(.textLinkColor)
                    .if(sponsoredAccessibilityHint != nil) { icon in
                        icon
                            .accessibilityElement()
                            .accessibilityHint(sponsoredAccessibilityHint ?? "")
                    }
            }
        }
        .accessibilityElement(children: .combine)
    }
    
    @ViewBuilder
    private var imageView: some View {
        if let image = image {
            image
                .frame(maxWidth: .infinity, maxHeight: Constants.maxImageHeight)
                .clipped()
        }
    }
}

// MARK: - Convenience initializers for when ImageContent is EmptyView
extension BPKSponsoredInsetBanner where ImageContent == EmptyView {
    /// Initialize a BPKSponsoredInsetBanner without an image
    ///
    /// - Parameters:
    ///   - logo: The logo content to display (required)
    ///   - sponsoredLabel: The sponsored label text (required)
    ///   - onSponsoredLabelTapped: Action to perform when tapping the sponsored label
    ///   - sponsoredAccessibilityHint: Optional accessibility hint for the sponsored label
    ///   - title: Optional title text
    ///   - subheadline: Optional subheadline text
    public init(
        logo: LogoContent,
        sponsoredLabel: String,
        onSponsoredLabelTapped: @escaping () -> Void,
        sponsoredAccessibilityHint: String? = nil,
        title: String? = nil,
        subheadline: String? = nil
    ) {
        self.logo = logo
        self.sponsoredLabel = sponsoredLabel
        self.sponsoredAccessibilityHint = sponsoredAccessibilityHint
        self.onSponsoredLabelTapped = onSponsoredLabelTapped
        self.title = title
        self.subheadline = subheadline
        self.image = nil
    }
}

private enum Constants {
    static let maxLogoWidth: CGFloat = 88.0
    static let maxLogoHeight: CGFloat = 22.0
    static let maxImageHeight: CGFloat = 120.0
}

struct BPKSponsoredInsetBanner_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .base) {
            BPKSponsoredInsetBanner(
                logo: Image("skyland").resizable().scaledToFit(),
                sponsoredLabel: "Sponsored",
                onSponsoredLabelTapped: {},
                title: "Title",
                subheadline: "Subheadline",
                image: Image("skyland").resizable().scaledToFit()
            )
            .frame(width: 375)
            
            BPKSponsoredInsetBanner(
                logo: Image("skyland").resizable().scaledToFit(),
                sponsoredLabel: "Sponsored",
                onSponsoredLabelTapped: {},
                title: "Title only"
            )
            .frame(width: 375)
        }
        .padding(.base)
    }
}

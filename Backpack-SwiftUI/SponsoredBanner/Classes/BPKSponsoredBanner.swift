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
 *   http://www.a=pache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SwiftUI

public struct BPKSponsoredBanner: View {
    private let logo: Image?
    private let title: String?
    private let subheadline: String?
    private let callToAction: CallToAction?
    private let bodyText: String?
    private let variant: Variant
    private let backgroundColor: Color
    private let customAccessibilityLabel: String?
    
    @State private var isExpanded: Bool
    
    public init(
        logo: Image? = nil,
        title: String? = nil,
        subheadline: String? = nil,
        callToAction: CallToAction? = nil,
        bodyText: String? = nil,
        variant: Variant,
        backgroundColor: Color,
        isExpanded: Bool = false,
        customAccessibilityLabel: String? = nil
    ) {
        self.logo = logo
        self.title = title
        self.subheadline = subheadline
        self.callToAction = callToAction
        self.bodyText = bodyText
        self.variant = variant
        self.backgroundColor = backgroundColor
        self.isExpanded = isExpanded
        self.customAccessibilityLabel = customAccessibilityLabel
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            topView
                .background(backgroundColor)
                .zIndex(1)
            bodyTextView
            
        }
        .background(
            RoundedRectangle(cornerRadius: .sm, style: .continuous)
                .foregroundColor(.sponsoredBannerBackgroundColor)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: .sm, style: .continuous)
        )
        .if(customAccessibilityLabel != nil) { view in
            view
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(customAccessibilityLabel ?? "")
        }
    }
    
    private var bodyTextView: some View {
        Group {
            if hasBody && isExpanded == true {
                BPKText(bodyText ?? "", style: .caption)
                    .lineLimit(4)
                    .frame(maxWidth: .infinity)
                    .padding(.base)
                    .background(Color.clear)
                    .zIndex(0)
            }
        }
    }
    
    private var hasBody: Bool {
        return bodyText != nil
    }
    
    private var topView: some View {
        Button(action: toggleBodyText) {
            buttonContent
        }
        .accessibilityRemoveTraits(hasBody ? [] : .isButton)
        .accessibilityElement(children: .combine)
        .buttonStyle(SponsoredBannerButtonStyle(
            foregroundColor: (variant == .onDark) ? Color(BPKColor.textOnDarkColor) : Color(BPKColor.textOnLightColor),
            backgroundColor: backgroundColor
        ))
    }
    
    private var buttonContent: some View {
        HStack(spacing: .md) {
            if let logo = logo {
                logo
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 22)
            }
            titlesView
            Spacer()
            if let callToAction = callToAction {
                BPKText(callToAction.text, style: .caption)
                    .foregroundColor(variant.color)
            }
            if callToAction?.showIcon == true {
                iconView
            }
        }
        .padding(.base)
    }
    
    private var titlesView: some View {
        VStack(alignment: .leading, spacing: .sm) {
            if let title = title {
                BPKText(title, style: .label2)
                    .foregroundColor(variant.color)
            }
            if let subheadline = subheadline {
                BPKText(subheadline, style: .caption)
                    .foregroundColor(variant.color)
            }
        }
    }
    
    private var iconView: some View {
        BPKIconView(.informationCircle)
            .foregroundColor(variant.color)
            .if(callToAction?.accessibilityLabel != nil) { icon in
                icon
                    .accessibilityElement()
                    .accessibilityHint(callToAction?.accessibilityLabel ?? "")
            }
    }
    
    private func toggleBodyText() {
        withAnimation(.spring()) {
            isExpanded.toggle()
        }
    }
}

extension BPKSponsoredBanner {
    public enum Variant {
        case onLight
        case onDark
        
        var color: Backpack_SwiftUI.BPKColor {
            (self == .onDark) ? BPKColor.textOnDarkColor : BPKColor.textOnLightColor
        }
        
        var buttonStyle: BPKButton.Style {
            (self == .onDark) ? .linkOnDark : .link
        }
    }
    
    public struct CallToAction {
        public let text: String
        public let accessibilityLabel: String
        public let showIcon: Bool
        
        public init(text: String, accessibilityLabel: String, showIcon: Bool = true) {
            self.text = text
            self.accessibilityLabel = accessibilityLabel
            self.showIcon = showIcon
        }
    }
}

struct BPKSponsoredBanner_Previews: PreviewProvider {
    static var previews: some View {
        BPKSponsoredBanner(
            title: "Title",
            subheadline: "Subheading",
            callToAction: .init(
                text: "Sponsored",
                accessibilityLabel: "More Information",
                showIcon: true),
            bodyText: "You can change your destination, date of travel," +
            " or both, with no change fee. Valid for all " +
            "new bookings made up to 31 May for travel between now and 31 December 2023.",
            variant: .onDark,
            backgroundColor: Color(red: 1.000, green: 0.400, blue: 0.004, opacity: 1.000))
        .padding()
    }
}

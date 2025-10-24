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

public struct BPKSponsoredInsetBanner<LogoContent: View>: View {
    private let logo: LogoContent
    private let title: String?
    private let subheadline: String?
    private let callToAction: CallToAction
    private let variant: Variant
    private let backgroundColor: Color
    private let customAccessibilityLabel: String?
    private let image: Image?
    
    public init(
        logoContent: LogoContent,
        title: String? = nil,
        subheadline: String? = nil,
        callToAction: CallToAction,
        variant: Variant,
        backgroundColor: Color,
        customAccessibilityLabel: String? = nil,
        image: Image? = nil
    ) {
        self.logo = logoContent
        self.title = title
        self.subheadline = subheadline
        self.callToAction = callToAction
        self.variant = variant
        self.backgroundColor = backgroundColor
        self.customAccessibilityLabel = customAccessibilityLabel
        self.image = image
    }
    
    public init(
        logoContent: LogoContent,
        subheadline: String? = nil,
        callToAction: CallToAction,
        variant: Variant,
        backgroundColor: Color,
        customAccessibilityLabel: String? = nil,
        image: Image? = nil
    ) {
        self.logo = logoContent
        self.title = nil
        self.subheadline = subheadline
        self.callToAction = callToAction
        self.variant = variant
        self.backgroundColor = backgroundColor
        self.customAccessibilityLabel = customAccessibilityLabel
        self.image = image
    }
    
    public init(
        logoContent: LogoContent,
        callToAction: CallToAction,
        variant: Variant,
        backgroundColor: Color,
        customAccessibilityLabel: String? = nil,
        image: Image? = nil
    ) {
        self.logo = logoContent
        self.title = nil
        self.subheadline = nil
        self.callToAction = callToAction
        self.variant = variant
        self.backgroundColor = backgroundColor
        self.customAccessibilityLabel = customAccessibilityLabel
        self.image = image
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            topView
                .background(backgroundColor)
                .zIndex(1)
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
        VStack(spacing: 0) {
            mainContent
                .padding(.horizontal, .base)
                .padding(.vertical, .md)
                .buttonStyle(SponsoredInsetBannerButtonStyle(
                    foregroundColor: (variant == .onDark) ?
                    Color(BPKColor.textOnDarkColor) :
                        Color(BPKColor.textOnLightColor),
                    backgroundColor: backgroundColor
                ))
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .clipped()
                    .contentShape(Rectangle())
            }
        }
    }
    
    private var mainContent: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: .md) {
                logo
                    .frame(maxWidth: Constants.maxLogoWidth, maxHeight: Constants.maxLogoHeight)
                    .fixedSize(horizontal: true, vertical: false)
                    .if(customAccessibilityLabel != nil) { view in
                        view
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(customAccessibilityLabel ?? "")
                    }
                Spacer()
                Button(action: callToAction.onClick) {
                    buttonContent
                        .largerHitArea(10)
                }
            }
            titlesView
        }
    }
    
    private var buttonContent: some View {
        HStack {
            BPKText(callToAction.text, style: .caption)
                .foregroundColor(variant.color)
                .lineLimit(nil)
            iconView
        }
    }
    
    private var titlesView: some View {
        HStack {
            VStack(alignment: .leading, spacing: .sm) {
                if let title {
                    BPKText(title, style: .label2)
                        .foregroundColor(variant.color)
                        .lineLimit(nil)
                }
                if let subheadline = subheadline {
                    BPKText(subheadline, style: .caption)
                        .foregroundColor(variant.color)
                        .lineLimit(nil)
                }
            }
            Spacer()
        }
    }
    
    private var iconView: some View {
        BPKIconView(.informationCircle)
            .foregroundColor(variant.color)
            .accessibilityElement()
            .accessibilityHint(callToAction.accessibilityHint)
    }
}

private enum Constants {
    static let maxLogoWidth: CGFloat = 88.0
    static let maxLogoHeight: CGFloat = 22.0
    static let maxImageHeight: CGFloat = 120.0
}

struct BPKSponsoredInsetBanner_Previews: PreviewProvider {
    static var previews: some View {
        BPKSponsoredInsetBanner(
            logoContent: Image("skyland").resizable().scaledToFit(),
            title: "Title",
            subheadline: "Subheading",
            callToAction: .init(
                text: "Sponsored",
                accessibilityHint: "Double tap for more information",
                onClick: {}
            ),
            variant: .onDark,
            backgroundColor: Color(red: 1.000, green: 0.400, blue: 0.004, opacity: 1.000))
        .padding(.base)
    }
}

fileprivate struct LargerHitArea: ViewModifier {
    var insets: CGFloat
    func body(content: Content) -> some View {
        content
            .padding(insets)
            .contentShape(Rectangle())
            .padding(-insets)
    }
}

fileprivate extension View {
    func largerHitArea(_ insets: CGFloat = 20) -> some View {
        modifier(LargerHitArea(insets: insets))
    }
}

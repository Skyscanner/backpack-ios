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

public struct BPKGraphicPromo: View {
    struct Sponsor {
        let title: String
        let logo: Image
        let accessibilityLabel: String
    }
    
    private let kicker: String?
    private let headline: String
    private let subheadline: String?
    private let image: Image
    
    private let type: `Type`
    private let overlay: BPKOverlayType
    private let variant: Variant
    private let verticalAlignment: VerticalAlignment
    
    private let action: () -> Void
    
    // MARK: - Adjustable settings (modifiers)
    private var backgroundColor = BPKColor.surfaceContrastColor
    private var sponsor: Sponsor?
    
    // MARK: - Internal settings
    private let sponsorLogoHeight = 60.0
    private let aspectRatio: CGFloat = 3/4
    private let padding = BPKSpacing.lg
    private let cornerRadius = BPKCornerRadius.md

    public init(
        kicker: String? = nil,
        headline: String,
        subheadline: String? = nil,
        image: Image,
        type: `Type` = .button,
        overlay: BPKOverlayType = .solid(.off),
        variant: Variant = .onDark,
        verticalAlignment: BPKGraphicPromo.VerticalAlignment = .top,
        action: @escaping () -> Void) {
            self.kicker = kicker
            self.headline = headline
            self.subheadline = subheadline
            self.image = image
            
            self.type = type
            self.overlay = overlay
            self.variant = variant
            
            self.verticalAlignment = verticalAlignment
            
            self.action = action
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .background(backgroundColor)
                .overlay(
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .bpkOverlay(overlay)
                )
                .accessibilityElement(children: .ignore)
            contentView()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(padding)
        }
        .cornerRadius(cornerRadius.value)
        .aspectRatio(aspectRatio, contentMode: .fit)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(contentAccessibilityLabel)
        .accessibilityAddTraits(type.accessibilityTraits)
    }
    
    // swiftlint:disable closure_body_length
    @ViewBuilder
    private func contentView() -> some View {
        VStack(alignment: .leading, spacing: .md) {
            if verticalAlignment == .bottom {
                if let sponsor {
                    sponsorOverlayView(sponsor)
                    Spacer()
                } else {
                    Spacer()
                }
            }
            
            if let kicker {
                BPKText(kicker, style: .label1)
                    .foregroundColor(variant.foregroundColor)
                    .lineLimit(nil)
            }
            
            BPKText(headline, style: .heading2)
                .foregroundColor(variant.foregroundColor)
                .lineLimit(nil)

            if let subheadline {
                BPKText(subheadline, style: .heading5)
                    .lineLimit(nil)
                    .foregroundColor(variant.foregroundColor)
            }
            
            if verticalAlignment == .top {
                if let sponsor {
                    Spacer()
                    sponsorOverlayView(sponsor)
                } else {
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    private func sponsorOverlayView(_ sponsor: Sponsor) -> some View {
        VStack(alignment: .leading, spacing: .md) {
            BPKText(sponsor.title, style: .label1)
                .foregroundColor(variant.foregroundColor)
            sponsor.logo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: sponsorLogoHeight)
        }
    }
    
    // MARK: - Helpers
    private var contentAccessibilityLabel: String {
        return [kicker, headline, subheadline, sponsor?.accessibilityLabel]
            .compactMap { $0 }
            .joined(separator: ", ")
    }
    
    // MARK: - Public modifiers
    public func sponsor(title: String, logo: Image, accessibilityLabel: String) -> BPKGraphicPromo {
        var view = self
        view.sponsor = Sponsor(title: title, logo: logo, accessibilityLabel: accessibilityLabel)
        return view
    }
    
    public func backgroundColor(_ color: BPKColor) -> BPKGraphicPromo {
        var view = self
        view.backgroundColor = color
        return view
    }
}

// swiftlint:disable closure_body_length
struct BPKGraphicPromo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // swiftlint:disable redundant_discardable_let
            let _ = BPKFont.setDynamicType(enabled: true)
            
            BPKGraphicPromo(headline: "Three peaks challenge", image: Image(systemName: "backpack.fill"), action: {})
                .backgroundColor(.coreAccentColor)
                .previewDisplayName("Headline")
            
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the trip in three days",
                image: Image(systemName: "backpack.fill"),
                action: {}
            )
            .backgroundColor(.coreAccentColor)
            .previewDisplayName("All options")
            
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the trip in three days",
                image: Image(systemName: "heart"),
                action: {}
            )
            .backgroundColor(.coreAccentColor)
            .sponsor(
                title: "Sponsored",
                logo: Image(systemName: "heart.fill"),
                accessibilityLabel: "Sponsored by: Skyland"
            )
            .previewDisplayName("Sponsored")
            
            ScrollView {
                BPKGraphicPromo(
                    kicker: "Travel tips",
                    headline: "Three peaks challenge",
                    subheadline: "How to complete the trip in three days",
                    image: Image(systemName: "heart"),
                    action: {}
                )
                .backgroundColor(.coreAccentColor)
                .sponsor(
                    title: "Sponsored",
                    logo: Image(systemName: "heart.fill"),
                    accessibilityLabel: "Sponsored by: Skyland"
                )
            }
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            .previewDisplayName("Accessibility")
        }
        .padding(.horizontal, .base)
    }
}

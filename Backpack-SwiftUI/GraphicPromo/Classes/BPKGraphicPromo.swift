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
    @Environment(\.sizeCategory) var sizeCategory
    
    private struct Sponsor {
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
    
    // MARK: - Adjustable settings (modifiers)
    private var tapAction : () -> Void = {}
    private var backgroundColor = Color(.surfaceContrastColor)
    private var sponsor: Sponsor?
    
    // MARK: - Internal settings
    private let sponsorLogoHeight = 32.0
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
        verticalAlignment: BPKGraphicPromo.VerticalAlignment = .top
    ) {
        self.kicker = kicker
        self.headline = headline
        self.subheadline = subheadline
        self.image = image
            
        self.type = type
        self.overlay = overlay
        self.variant = variant
            
        self.verticalAlignment = verticalAlignment
    }
    
    public init(
        headline: String,
        image: Image,
        variant: Variant = .onDark,
        sponsorTitle: String,
        partnerLogo: Image,
        sponsoredAccessibilityLabel: String
    ) {
        self.headline = headline
        self.kicker = ""
        self.subheadline = nil
        self.image = image
        self.type = .button
        self.overlay = .linear(.high, .bottom)
        self.variant = variant
        self.verticalAlignment = .bottom
        
        self.sponsor = .init(
            title: sponsorTitle,
            logo: partnerLogo,
            accessibilityLabel: sponsoredAccessibilityLabel)
    }
    
    public var body: some View {
        Button(action: tapAction) {
            contentView()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(padding)
        }
        .buttonStyle(GraphicPromoButtonStyle(
            image: image,
            overlay: overlay,
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius
        ))
        .if(sizeCategory < .accessibilityExtraLarge, transform: {
            $0.aspectRatio(aspectRatio, contentMode: .fit)
        })
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(contentAccessibilityLabel)
        .accessibilityAddTraits(type.accessibilityTraits)
    }
    
    // swiftlint:disable closure_body_length
    @ViewBuilder
    private func contentView() -> some View {
        Group {
            if let sponsor {
                sponsorContentView(sponsor)
            } else {
                Spacer()
                VStack(alignment: .leading, spacing: .md) {
                    if verticalAlignment == .bottom {
                        Spacer()
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
                        Spacer()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func sponsorContentView(_ sponsor: Sponsor) -> some View {
        VStack(alignment: .leading, spacing: .md) {
            Spacer()
            BPKText(Text(headline).bold(), style: .heading2)
                .foregroundColor(variant.foregroundColor)
                .lineLimit(nil)
            
            if #available(iOS 16.0, *) {
                ViewThatFits {
                    HStack(spacing: .md) {
                        sponsorLogo
                        sponsoredText
                    }
                    
                    VStack(alignment: .leading, spacing: .md) {
                        sponsorLogo
                        sponsoredText
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var sponsorLogo: some View {
        if let sponsor {
            sponsor.logo
                .resizable()
                .scaledToFit()
                .frame(height: sponsorLogoHeight)
                .foregroundStyle(Color(variant.foregroundColor.value))
                .frame(maxWidth: 160)
                .fixedSize()
        }
    }
    
    @ViewBuilder
    private var sponsoredText: some View {
        if let sponsor {
            BPKText(sponsor.title, style: .caption)
                .foregroundColor(variant.foregroundColor)
                .foregroundStyle(Color(variant.foregroundColor.value))
        }
    }
    
    // MARK: - Helpers
    private var contentAccessibilityLabel: String {
        return [kicker, headline, subheadline, sponsor?.accessibilityLabel]
            .compactMap { $0 }
            .joined(separator: ", ")
    }
    
    // MARK: - Public modifiers
    public func fallbackColor(_ color: Color) -> BPKGraphicPromo {
        var view = self
        view.backgroundColor = color
        return view
    }
    
    public func onTapGesture(perform: @escaping () -> Void) -> BPKGraphicPromo {
        var result = self
        result.tapAction = {
            let hapticFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            hapticFeedbackGenerator.impactOccurred()
            perform()
        }
        return result
    }
}

private struct GraphicPromoButtonStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    let image: Image
    let overlay: BPKOverlayType
    let backgroundColor: Color
    let cornerRadius: BPKCornerRadius

    func makeBody(configuration: Configuration) -> some View {
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
                        .overlay(
                            Color(.scrimColor)
                                .opacity(configuration.isPressed ? 0.2 : 0)
                                .animation(.easeInOut)
                                .allowsHitTesting(false)
                        )
                        .if(!reduceMotion, transform: {
                            $0.scaleEffect(configuration.isPressed ? 1.05 : 1)
                        })
                )
                .accessibilityElement(children: .ignore)
            configuration.label
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .animation(.interpolatingSpring(
            mass: 1,
            stiffness: 800,
            damping: 100
        ), value: configuration.isPressed)
    }
}

struct BPKGraphicPromo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScrollView {
                BPKGraphicPromo(
                    headline: "Three peaks challenge",
                    image: Image(systemName: "backpack.fill")
                )
                .fallbackColor(Color(.coreAccentColor))
            }
            .previewDisplayName("Headline")
            
            ScrollView {
                BPKGraphicPromo(
                    kicker: "Travel tips",
                    headline: "Three peaks challenge",
                    subheadline: "How to complete the trip in three days",
                    image: Image(systemName: "backpack.fill")
                )
                .fallbackColor(Color(.coreAccentColor))
            }
            .previewDisplayName("All options")
            
            ScrollView {
                BPKGraphicPromo(
                    headline: "There's always more to explore in Britain",
                    image: Image(systemName: "heart"),
                    sponsorTitle: "In partnership with Skyland",
                    partnerLogo: Image(systemName: "heart.fill"),
                    sponsoredAccessibilityLabel: "Sponsored by: Skyland"
                )
                .fallbackColor(Color(.coreAccentColor))
            }
            .previewDisplayName("Sponsored")
            
            ScrollView {
                BPKGraphicPromo(
                    headline: "There's always more to explore in Britain",
                    image: Image(systemName: "heart"),
                    sponsorTitle: "In partnership with Skyland",
                    partnerLogo: Image(systemName: "heart.fill"),
                    sponsoredAccessibilityLabel: "Sponsored by: Skyland"
                )
                .fallbackColor(Color(.coreAccentColor))
            }
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            .previewDisplayName("Accessibility")
        }
        .padding(.horizontal, .base)
    }
}

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

public struct BPKGraphicPromo: View {
    private let kicker: String?
    private let headline: String
    private let subheadline: String?
    private let image: Image
    
    private let type: `Type`
    private let overlay: BPKOverlayType
    private let variant: Variant
    private let verticalAlignment: VerticalAlignment
    
    private let action: () -> Void
    
    // Settings
    private let sponsorLogoHeight = 60.0
    private let aspectRatio: CGFloat = 3/4
    private let padding = BPKSpacing.lg
    
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
        image
            .resizable()
            .aspectRatio(aspectRatio, contentMode: .fit)
            .background(.coreEcoColor)
            .bpkOverlay(overlay)
            .overlay(
                contentView().padding(padding),
                alignment: verticalAlignment.contentAlignment
            )
            .cornerRadius(BPKCornerRadius.md.value)
            .accessibilityAddTraits(type.accessibilityTraits)
            .onTapGesture {
                action()
            }
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        VStack(alignment: .leading, spacing: .md) {
            if let kicker {
                BPKText(kicker, style: .label1)
                    .foregroundColor(variant.foregroundColor)
            }
            BPKText(headline, style: .heading2)
                .foregroundColor(variant.foregroundColor)
                .lineLimit(nil)
            if let subheadline {
                BPKText(subheadline, style: .heading5)
                    .lineLimit(nil)
                    .foregroundColor(variant.foregroundColor)
            }
        }
    }
    
    @ViewBuilder
    private func sponsorOverlayView(title: String, logo: Image) -> some View {
        VStack(alignment: .leading, spacing: .md) {
            BPKText(title, style: .label1)
                .foregroundColor(variant.foregroundColor)
            logo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: sponsorLogoHeight)
                .accessibilityLabel(contentAccessibilityLabel)
        }
    }
    
    // MARK: - Helpers
    private var contentAccessibilityLabel: String {
        return [kicker, headline, subheadline]
            .compactMap { $0 }
            .joined(separator: ", ")
    }
    
    // MARK: - Public modifiers
    public func sponsor(title: String, logo: Image, accessibilityLabel: String) -> some View {
        return self
            .overlay(
                sponsorOverlayView(title: title, logo: logo).padding(padding),
                alignment: verticalAlignment.sponsorAlignment)
            .accessibilityLabel(contentAccessibilityLabel + ", " + accessibilityLabel)
    }
}

public extension BPKGraphicPromo {
    enum `Type` {
        case button, link
        
        var accessibilityTraits: AccessibilityTraits {
            self == .button ? .isButton : .isLink
        }
    }
    
    enum Variant {
        case onDark, onLight
        
        var foregroundColor: BPKColor {
            self == .onDark ? .textOnDarkColor : .textOnLightColor
        }
    }
    
    enum VerticalAlignment {
        case top, bottom
        
        var contentAlignment: Alignment {
            self == .top ? .topLeading : .bottomLeading
        }
        
        var sponsorAlignment: Alignment {
            self == .top ? .bottomLeading : .topLeading
        }
    }
    
    enum HorizontalAlignment {
        case leading, center, trailing
    }
}

// swiftlint:disable closure_body_length
struct BPKGraphicPromo_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            BPKGraphicPromo(
                headline: "Three peaks challenge",
                image: Image(decorative: "Barcelona-CasaBatllo"),
                overlay: .solid(.high)
            ) {
                print("Test")
            }
            .sponsor(
                title: "Sponsored",
                logo: Image(systemName: "heart.fill"),
                accessibilityLabel: "Hello!"
            )
            .padding(.horizontal, 16)
            
            BPKGraphicPromo(
                headline: "Three peaks challenge",
                image: Image(decorative: "Barcelona-CasaBatllo"),
                verticalAlignment: .bottom
            ) {
                print("Test")
            }
            .sponsor(
                title: "Sponsored",
                logo: Image(systemName: "heart.fill"),
                accessibilityLabel: "Hello!"
            )
            .padding(.horizontal, 16)
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the climb in 3 days",
                image: Image(decorative: "Barcelona-CasaBatllo")
            ) {
                print("Test")
            }
            .padding(.horizontal, 16)
        }
    }
}

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

/// A control that displays an icon and a non-editable text interface.
public struct BPKBannerAlert: View {
    private let type: AlertType
    private let style: Style
    private let message: String
    private let icon: BPKIconView?
    private let accessibilityIdentifier: String?
   
    /// Creates a `BPKBannerAlert`.
    ///
    /// - Parameters:
    ///   - type: Controls which default icon to display in the banner.
    ///   - style: Style of the alert (default, onContrast). It controls the alert background color.
    ///   - message: The text to display in BPKText.
    ///   - icon: Custom icon to use in the banner, instead of the default ones.
    ///   - accessibilityIdentifier: Identifier assigned to the entire banner.
    public init(
        type: AlertType = .info(),
        style: Style = .default,
        message: String,
        icon: BPKIconView? = nil,
        accessibilityIdentifier: String? = nil
    ) {
        self.type = type
        self.style = style
        self.message = message
        self.icon = icon
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    @ScaledMetric private var iconTopPadding: CGFloat = 1
    
    public var body: some View {
        let verticalPadding = BPKSpacing.md.value + BPKSpacing.sm.value
        HStack(alignment: .top, spacing: .md) {
            accessory
                .padding(.top, iconTopPadding)
            
            BPKText(message, style: .footnote)
                .lineLimit(.max)
                .accessibilityLabel(message)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, .base)
        .padding(.vertical, verticalPadding)
        .background(style.color)
        .clipShape(RoundedRectangle(cornerRadius: .sm))
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(accessibilityIdentifier ?? "")
        
    }
    
    @ViewBuilder
    private var accessory : some View {
        if let icon {
            icon
        } else {
            BPKIconView(type.iconDetails.icon, accessibilityLabel: type.iconDetails.accessibilityLabel ?? "")
                .foregroundColor(type.iconDetails.color)
        }
    }
}

struct BPKBannerAlert_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack {
                ForEach([0, 1], id: \.self) { id in
                    let style: BPKBannerAlert.Style = id == 0 ? .default : .onContrast
                    let title = id == 0 ? "Default" : "On Contrast"
                    VStack {
                        Text("\(title) Style")
                            .font(.title)
                        BPKBannerAlert(style: style, message: "Info Banner")
                        BPKBannerAlert(type: .warning(), style: style, message: "Warning Banner")
                        BPKBannerAlert(type: .success(), style: style, message: "Success Banner")
                        BPKBannerAlert(type: .error(), style: style, message: "Error Banner")
                        BPKBannerAlert(type: .info(), style: style, message: "Mutli-line Banner \nThis is a new line")
                    }
                    .padding()
                    .background(id == 0 ? .canvasColor : .canvasContrastColor)
                }
            }
        }
    }
}

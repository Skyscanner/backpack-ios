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

/// A view that displays an icon and a non-editable text.
public struct BPKBannerAlert: View {
    private let type: AlertType
    private let style: Style
    private let message: String
    private let customIcon: (icon: BPKIcon, accessibilityLabel: String)?
   
    /// Creates a `BPKBannerAlert`.
    ///
    /// - Parameters:
    ///   - type: Controls which default icon to display in the banner.
    ///   - style: Style of the alert (default, onContrast). It controls the alert background color.
    ///   - message: The text to display in BPKText.
    ///   - icon: Custom icon to use in the banner instead of the one associated with the AlertType.
    public init(
        type: AlertType,
        style: Style = .default,
        message: String,
        customIcon: (icon: BPKIcon, accessibilityLabel: String)? = nil
    ) {
        self.type = type
        self.style = style
        self.message = message
        self.customIcon = customIcon
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
        
    }
    
    private var accessory : some View {
        let icon: BPKIcon
        let accessibilityLabel: String
        if let customIcon {
            icon = customIcon.icon
            accessibilityLabel = customIcon.accessibilityLabel
        } else {
            icon = type.iconDetails.icon
            accessibilityLabel = type.iconDetails.accessibilityLabel
        }
        
        return BPKIconView(icon, accessibilityLabel: accessibilityLabel)
            .foregroundColor(type.iconDetails.color)
    }
}

// swiftlint:disable line_length
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
                        BPKBannerAlert(type: .info(accessibilityLabel: "Information"), style: style, message: "Info Banner")
                        BPKBannerAlert(type: .warning(accessibilityLabel: "Warning"), style: style, message: "Warning Banner")
                        BPKBannerAlert(type: .success(accessibilityLabel: "Success"), style: style, message: "Success Banner")
                        BPKBannerAlert(type: .error(accessibilityLabel: "Error"), style: style, message: "Error Banner")
                        BPKBannerAlert(type: .info(accessibilityLabel: "Info"), style: style, message: "Mutli-line Banner \nThis is a new line")
                    }
                    .padding()
                    .background(id == 0 ? .canvasColor : .canvasContrastColor)
                }
            }
        }
    }
}

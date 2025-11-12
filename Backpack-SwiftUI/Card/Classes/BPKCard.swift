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
import Backpack_Common

public struct BPKCard<Content: View>: View {
    public enum CornerStyle {
        case large, small
    }

    public enum Padding {
        case none, small

        var value: BPKSpacing {
            self == .small ? .base : .none
        }
    }

    private let elevation: BPKCardElevation
    private let content: Content
    private let padding: Padding
    private let cornerStyle: CornerStyle
    private let style: Style
    private var tapAction : () -> Void = {}
    private let config: BpkConfiguration?

    public init(
        padding: Padding = .small,
        cornerStyle: CornerStyle = .small,
        elevation: BPKCardElevation = .default,
        style: Style = .onContrast,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.cornerStyle = cornerStyle
        self.padding = padding
        self.elevation = elevation
        self.style = style
        self.config = BpkConfiguration.shared
    }

    private var cornerRadius: BPKCornerRadius {
        cornerStyle == .small ? .sm : .lg
    }

    private var effectiveElevation: BPKCardElevation {
        config?.cardConfig != nil ? .none : elevation
    }

    private var backgroundColor: BPKColor {
        switch style {
        case .onDefault:
            return .canvasContrastColor
        case .onContrast:
            return effectiveElevation == .focus ? .surfaceElevatedColor : .surfaceDefaultColor
        }
    }

    public var body: some View {
        Button(action: tapAction) {
            content
                .padding(padding.value)
        }
        .buttonStyle(CardButtonStyle(
            cornerRadius: cornerRadius,
            backgroundColor: backgroundColor
        ))
        .shadow(effectiveElevation.shadow)
    }
    
    public func onTapGesture(perform: @escaping () -> Void) -> BPKCard {
        var result = self
        result.tapAction = perform
        return result
    }
}

private struct CardButtonStyle: ButtonStyle {
    let cornerRadius: BPKCornerRadius
    let backgroundColor: BPKColor

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .overlay(
                Color(.surfaceContrastColor)
                    .opacity(configuration.isPressed ? 0.2 : 0)
                    .animation(.easeInOut)
                    .allowsHitTesting(false)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }

}

struct BPKCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            BPKCard() {
                BPKText("Default")
            }
            BPKCard(elevation: .focus) {
                BPKText("Focused")
            }
            BPKCard(padding: .none) {
                BPKText("Not Padded")
            }
            BPKCard(cornerStyle: .large) {
                BPKText("Large Corner")
            }
            BPKCard(style: .onDefault) {
                BPKText("On Default Style")
            }
            BPKCard(elevation: .focus, style: .onDefault) {
                BPKText("Focused On Default")
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

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
    private var tapAction : () -> Void = {}
    
    @State private var selectionOverlayOpacity = 0.0

    public init(
        padding: Padding = .small,
        cornerStyle: CornerStyle = .small,
        elevation: BPKCardElevation = .default,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.cornerStyle = cornerStyle
        self.elevation = elevation
        self.padding = padding
    }

    private var cornerRadius: BPKCornerRadius {
        cornerStyle == .small ? .sm : .lg
    }

    public var body: some View {
        content
            .padding(padding.value)
            .frame(maxWidth: .infinity)
            .background(elevation.backgroundColor)
            .overlay(
                Color(.surfaceContrastColor)
                    .opacity(selectionOverlayOpacity)
                    .animation(.easeInOut)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(elevation.shadow)
            .onTapGesture {
                selectionOverlayOpacity = 0.2
                withAnimation {
                    selectionOverlayOpacity = 0
                }
                tapAction()
            }
    }
    
    public func onTapGesture(perform: @escaping () -> Void) -> BPKCard {
        var result = self
        result.tapAction = perform
        return result
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
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

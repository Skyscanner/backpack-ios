/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

/// A view that clips its content to a shape with a flare at one end.
public struct BPKFlareView<Content: View>: View {
    private let size: BPKFlareSize
    private var roundedCorners: Bool
    private let direction: BPKFlareDirection
    @ViewBuilder private let content: Content
    
    /// Creates a view that clips its content to a shape with a flare at one end.
    /// - Parameters:
    ///   - size: The size of the flare. Default is `.medium`.
    ///   - roundedCorners: Whether to round the corners of the shape. Default is `true`.
    ///   - direction: The direction of the flare. Default is `.bottom`.
    ///   - content: The content to clip to the shape.
    public init(
        size: BPKFlareSize = .medium,
        roundedCorners: Bool = true,
        direction: BPKFlareDirection = .bottom,
        content: () -> Content
    ) {
        self.size = size
        self.roundedCorners = roundedCorners
        self.direction = direction
        self.content = content()
    }
    
    public var body: some View {
        content
            .clipShape(
                FlarePath(
                    flareHeight: size.flareHeight,
                    cornerRadius: roundedCorners ? .base : .none,
                    direction: direction
                )
            )
    }
}

/// The size of the flare.
public enum BPKFlareSize {
    case small, medium, large
    
    var flareHeight: CGFloat {
        switch self {
        case .small: return 8
        case .medium: return 16
        case .large: return 24
        }
    }
}

/// The direction of the flare.
public enum BPKFlareDirection {
    case top, bottom
    
    var scaleFactor: CGFloat {
        self == .top ? -1 : 1
    }
}

// swiftlint:disable closure_body_length
struct BPKFlareView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKFlareView {
                VStack {
                    HStack {
                        BPKText("Flare View!")
                            .foregroundColor(.textPrimaryInverseColor)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: 200, height: 100)
                .padding()
                .padding(.bottom)
                .background(.coreAccentColor)
            }
            BPKFlareView {
                VStack {
                    BPKText("Flare View!")
                        .foregroundColor(.textPrimaryInverseColor)
                }
                .padding()
                .padding(.bottom)
                .background(.coreAccentColor)
            }
            BPKFlareView(roundedCorners: false) {
                VStack {
                    BPKText("Flare View!")
                        .foregroundColor(.textPrimaryInverseColor)
                }
                .padding()
                .padding(.bottom)
                .background(.coreAccentColor)
            }
            BPKFlareView(direction: .top) {
                VStack {
                    BPKText("Flare View!")
                        .foregroundColor(.textPrimaryInverseColor)
                }
                .padding()
                .padding(.top)
                .background(.coreAccentColor)
            }
            BPKFlareView(size: .small) {
                VStack {
                    BPKText("Flare View!")
                        .foregroundColor(.textPrimaryInverseColor)
                }
                .padding()
                .padding(.bottom, .md)
                .background(.coreAccentColor)
            }
        }
    }
}

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

import MapKit
import SwiftUI

public struct BPKPriceMapMarker: View {
    enum State {
        case `default`
        case focused
        case viewed
        case disabled
        
        var fontStyle: BPKFontStyle {
            switch self {
            case .default:
                return .label2
            case .focused:
                return .label1
            case .viewed:
                return .label2
            case .disabled:
                return .label2
            }
        }
        
        var foregroundColor: BPKColor {
            switch self {
            case .default:
                return .textPrimaryInverseColor
            case .focused:
                return .coreAccentColor
            case .viewed:
                return .init(value: .white.withAlphaComponent(0.8))
                    .darkVariant(.init(value: .black.withAlphaComponent(0.8)))
            case .disabled:
                return .textDisabledColor
            }
        }
        
        var backgroundColor: BPKColor {
            switch self {
            case .default:
                return .coreAccentColor
            case .focused:
                return .surfaceDefaultColor
            case .viewed:
                return .coreAccentColor
            case .disabled:
                return .surfaceDefaultColor
            }
        }
    }
    
    let state: State
    let price: String
    
    public var body: some View {
        BPKFlareViewMap(
            size: .small,
            direction: .bottom,
            content: content
        )
        .shadow(.sm)
    }
    
    @ViewBuilder
    func content() -> some View {
        if case .focused = state {
            VStack(spacing: BPKSpacing.none) {
                BPKText(price, style: state.fontStyle)
                    .foregroundColor(state.foregroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: .xs))
                    .padding(.vertical, 4)
                    .padding(.horizontal, .md)
                    .overlay(
                        RoundedRectangle(cornerRadius: .xs)
                            .stroke(Color(.coreAccentColor), lineWidth: 4)
                    )
                    .background(state.backgroundColor)
                Color(.coreAccentColor)
                    .frame(width: 16, height: 6)
            }
        } else {
            BPKText(price, style: state.fontStyle)
                .foregroundColor(state.foregroundColor)
                .padding(.bottom, 6)
                .padding(.vertical, 4)
                .padding(.horizontal, .md)
                .background(state.backgroundColor)
        }
    }
}

public struct BPKPointerMapMarker: View {
    
    public var body: some View {
        Circle()
            .stroke(Color(.surfaceDefaultColor), lineWidth: 2)
            .background(Circle().foregroundColor(.coreAccentColor))
            .frame(width: .base, height: .base)
            
    }
}

public struct BPKPoiMapMarker: View {
    enum State {
        case `default`
        case focused
        case disabled
        
        var fontStyle: BPKFontStyle {
            switch self {
            case .default:
                return .label2
            case .focused:
                return .label1
            case .disabled:
                return .label2
            }
        }
        
        var foregroundColor: BPKColor {
            switch self {
            case .default:
                return .textPrimaryInverseColor
            case .focused:
                return .coreAccentColor
            case .disabled:
                return .textDisabledColor
            }
        }
        
        var backgroundColor: BPKColor {
            switch self {
            case .default:
                return .coreAccentColor
            case .focused:
                return .surfaceDefaultColor
            case .disabled:
                return .surfaceDefaultColor
            }
        }
    }
    
    let state: State
    let icon: BPKIcon
    
    public var body: some View {
        BPKIconView(icon)
            .background(state.backgroundColor)
            .clipShape(BPKPOIMapMarkerShape())
    }
}

/// A view that clips its content to a shape with a flare at one end.
struct BPKPOIMapMarkerShape: Shape {
    /// Creates a path with a flare at one end.
    func path(in rect: CGRect) -> Path {
        let size = rect.size
        return Path { path in
            let contentRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            path.addRoundedRect(
                in: contentRect,
                cornerSize: CGSize(width: 5, height: 5))
        }
    }
    
    /// Appends a flare to the path.
    /// - Parameters:
    ///   - path: The path to append the flare to.
    ///   - size: The size of the bounding rectangle of the path.
    ///   - flareHeight: The height of the flare.
    private func appendFlare(to path: inout Path, size: CGSize, flareHeight: CGFloat) {
        
        // The scale factor to adjust the size of the flare
        
        let startPointY = size.height - flareHeight
        
        let centerPoint = (size.width / 2)
        path.move(to: CGPoint(x: centerPoint - 8, y: startPointY))
        
        let courvePoint: CGFloat = 2
        path.addLine(to: CGPoint(x: centerPoint - courvePoint, y: size.height - courvePoint / 2))
        
        let center = CGPoint(x: centerPoint + courvePoint, y: size.height - courvePoint / 2)
        let curveCenter1 = CGPoint(x: centerPoint - courvePoint / 2, y: startPointY + flareHeight)
        let curveCenter2 = CGPoint(x: centerPoint + courvePoint / 2, y: startPointY + flareHeight)
        path.addCurve(to: center, control1: curveCenter1, control2: curveCenter2)
        
        path.addLine(to: CGPoint(x: centerPoint + 8, y: startPointY))
        
    }
}

/// A view that clips its content to a shape with a flare at one end.
struct BPKFlareViewMap<Content: View>: View {
    private let size: BPKFlareSize
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
        direction: BPKFlareDirection = .bottom,
        content: () -> Content
    ) {
        self.size = size
        self.direction = direction
        self.content = content()
    }
    
    var body: some View {
        content
            .clipShape(
                FlarePath(
                    flareHeight: 6,
                    cornerRadius: .sm,
                    direction: direction
                )
            )
    }
    
    struct FlarePath: Shape {
        /// The height of the flare.
        let flareHeight: CGFloat
        /// The corner radius of the rounded rectangle.
        let cornerRadius: BPKSpacing
        /// The direction of the flare.
        let direction: BPKFlareDirection
        
        /// Creates a path with a flare at one end.
        func path(in rect: CGRect) -> Path {
            let size = rect.size
            return Path { path in
                let contentTop = direction == .top ? flareHeight : 0
                let contentBottom = direction == .top ? size.height : size.height - flareHeight
                
                let contentRect = CGRect(x: 0, y: contentTop, width: size.width, height: contentBottom - contentTop)
                path.addRoundedRect(
                    in: contentRect,
                    cornerSize: CGSize(width: cornerRadius.value, height: cornerRadius.value))
                appendFlare(to: &path, size: size, flareHeight: flareHeight)
            }
        }

        /// Appends a flare to the path.
        /// - Parameters:
        ///   - path: The path to append the flare to.
        ///   - size: The size of the bounding rectangle of the path.
        ///   - flareHeight: The height of the flare.
        private func appendFlare(to path: inout Path, size: CGSize, flareHeight: CGFloat) {
            
            // The scale factor to adjust the size of the flare
            
            let startPointY = size.height - flareHeight
            
            let centerPoint = (size.width / 2)
            path.move(to: CGPoint(x: centerPoint - 8, y: startPointY))
            
            let courvePoint: CGFloat = 2
            path.addLine(to: CGPoint(x: centerPoint - courvePoint, y: size.height - courvePoint / 2))
            
            let center = CGPoint(x: centerPoint + courvePoint, y: size.height - courvePoint / 2)
            let curveCenter1 = CGPoint(x: centerPoint - courvePoint / 2, y: startPointY + flareHeight)
            let curveCenter2 = CGPoint(x: centerPoint + courvePoint / 2, y: startPointY + flareHeight)
            path.addCurve(to: center, control1: curveCenter1, control2: curveCenter2)
            
            path.addLine(to: CGPoint(x: centerPoint + 8, y: startPointY))
        }
    }
}

struct BPKPriceMapMarker_Previews: PreviewProvider {
    struct Annotation: Identifiable {
        // swiftlint:disable nesting
        enum Marker {
            case price(String, BPKPriceMapMarker.State)
            case poi(BPKIcon, BPKPoiMapMarker.State)
            case pointer
        }
        let id = UUID()
        let marker: Marker
        let coordinate: CLLocationCoordinate2D
    }
    
    static var previews: some View {
        Map(
            coordinateRegion: .constant(.init(
                center: .init(latitude: 51.5, longitude: -0.1),
                span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )),
            annotationItems: [
                Annotation(
                    marker: .price("£200", .default),
                    coordinate: .init(latitude: 51.55, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("£200", .focused),
                    coordinate: .init(latitude: 51.53, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("£200", .viewed),
                    coordinate: .init(latitude: 51.51, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("Sold out", .disabled),
                    coordinate: .init(latitude: 51.49, longitude: -0.1)
                ),
                Annotation(
                    marker: .pointer,
                    coordinate: .init(latitude: 51.47, longitude: -0.1)
                ),
                Annotation(
                    marker: .poi(.landmark, .default),
                    coordinate: .init(latitude: 51.55, longitude: -0.04)
                ),
                Annotation(
                    marker: .poi(.landmark, .focused),
                    coordinate: .init(latitude: 51.53, longitude: -0.04)
                ),
                Annotation(
                    marker: .poi(.landmark, .disabled),
                    coordinate: .init(latitude: 51.51, longitude: -0.04)
                )
            ]) { item in
                MapAnnotation(coordinate: item.coordinate) {
                    switch item.marker {
                    case .price(let price, let state):
                        BPKPriceMapMarker(state: state, price: price)
                    case .poi(let icon, let state):
                        BPKPoiMapMarker(state: state, icon: icon)
                    case .pointer:
                        BPKPointerMapMarker()
                    }
                }
        }
    }
}

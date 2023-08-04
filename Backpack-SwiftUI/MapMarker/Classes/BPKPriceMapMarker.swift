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
        ZStack {
            Color(state.backgroundColor)
                .frame(width: 26, height: 32)
                .clipShape(BPKPOIMapMarkerShape())
                
            BPKIconView(icon)
                .foregroundColor(state.foregroundColor)
                .padding(.bottom, 6)
        }
    }
}

/// A view that clips its content to a shape with a flare at one end.
struct BPKPOIMapMarkerShape: Shape {
    /// Creates a path with a flare at one end.
    func path(in rect: CGRect) -> Path {
        let size = rect.size
        return Path { path in
            path.addRelativeArc(
                center: .init(x: size.width / 2, y: size.width / 2),
                radius: size.width / 2,
                startAngle: .degrees(30),
                delta: .degrees(-240)
            )

            let courvePoint: CGFloat = 3
            let startPoint = CGPoint(x: size.width / 2, y: size.height - courvePoint)

            path.addRelativeArc(
                center: startPoint,
                radius: courvePoint,
                startAngle: .degrees(120),
                delta: .degrees(-60)
            )
        }
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
            .clipShape(FlarePath())
    }
    
    struct FlarePath: Shape {
        let flareSize = CGSize(width: 16, height: 6)
        let cornerRadius = BPKSpacing.sm
        
        func path(in rect: CGRect) -> Path {
            let size = rect.size
            return Path { path in
                path.addRoundedRect(
                    in: CGRect(
                        origin: .zero,
                        size: CGSize(width: size.width, height: size.height - flareSize.height)
                    ),
                    cornerSize: CGSize(width: cornerRadius.value, height: cornerRadius.value))
                appendFlare(
                    to: &path,
                    startPoint: CGPoint(x: size.width / 2, y: size.height),
                    flareSize: flareSize
                )
            }
        }
        
        private func appendFlare(to path: inout Path, startPoint: CGPoint, flareSize: CGSize) {
            let startPointY = startPoint.y - flareSize.height
            let centerPoint = startPoint.x
            path.move(to: CGPoint(x: centerPoint - flareSize.width / 2, y: startPointY))
            
            let courvePoint: CGFloat = 2
            path.addLine(to: CGPoint(x: centerPoint - courvePoint, y: startPoint.y - courvePoint / 2))
            
            let center = CGPoint(x: centerPoint + courvePoint, y: startPoint.y - courvePoint / 2)
            let curveCenter1 = CGPoint(x: centerPoint - courvePoint / 2, y: startPointY + flareSize.height)
            let curveCenter2 = CGPoint(x: centerPoint + courvePoint / 2, y: startPointY + flareSize.height)
            path.addCurve(to: center, control1: curveCenter1, control2: curveCenter2)
            
            path.addLine(to: CGPoint(x: centerPoint + flareSize.width / 2, y: startPointY))
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
        VStack {
            BPKPoiMapMarker(state: .default, icon: .landmark)
            BPKPoiMapMarker(state: .default, icon: .landmark)
            BPKPoiMapMarker(state: .default, icon: .landmark)
            Spacer()
        }
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

/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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

public struct BPKPriceRange: View {
    public let configuration: Configuration
    
    private let barSpacing: CGFloat = 2
    private let segmentLabelHeight: CGFloat = 20
    private let markerFlareHeight: CGFloat = 6
    @Environment(\.layoutDirection) private var layoutDirection
    
    public init (configuration: Configuration) {
        self.configuration = configuration
    }
    
    public var body: some View {
        Group {
            switch configuration {
            case .default(let defaultConfig):
                VStack(spacing: .sm) {
                    markerView
                    barView
                    segmentLabels(segments: defaultConfig.segments)
                }
            case .collapsed:
                ZStack {
                    barView
                    markerView
                }
            }
        }
        .accessibilityElement(children: .ignore)
    }
    
    private var barView: some View {
        GeometryReader { geometry in
            HStack(spacing: barSpacing) {
                RoundedCustomCornersShape(
                    radius: configuration.barHeight,
                    corners: layoutDirection == .leftToRight ?  [.topLeft, .bottomLeft] : [.topRight, .bottomRight]
                )
                .fill(Color(.statusSuccessSpotColor))
                .frame(width: leadingBarWidth(availableWidth: geometry.size.width))
                
                Rectangle()
                    .fill(Color(.corePrimaryColor))
                    .frame(width: middleBarWidth(availableWidth: geometry.size.width))
                
                RoundedCustomCornersShape(
                    radius: configuration.barHeight,
                    corners: layoutDirection == .leftToRight ? [.topRight, .bottomRight] : [.topLeft, .bottomLeft]
                )
                .fill(Color(.statusDangerSpotColor))
                .frame(width: trailingBarWidth(availableWidth: geometry.size.width))
            }
        }
        .frame(height: configuration.barHeight)
    }
    
    private var markerView: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: geometry.size.width)
                    .layoutPriority(1)
                Group {
                    switch configuration {
                    case .default(let defaultConfig):
                        labelMarker(text: defaultConfig.marker.text)
                    case .collapsed:
                        circleMarker
                    }
                }
                .layoutPriority(0)
                .alignmentGuide(HorizontalAlignment.center) { viewDimensions in
                    viewDimensions[HorizontalAlignment.center] +
                    positionOffset(for: configuration.markerPercentage, availableWidth: geometry.size.width)
                }
            }
        }
        .frame(height: configuration.markerHeight)
    }
    
    private var circleMarker: some View {
        ZStack {
            Circle().fill(Color(configuration.markerBackgroundColor)).frame(height: configuration.markerHeight)
            Circle().fill(Color(.textPrimaryInverseColor)).frame(height: .sm)
        }
    }
    
    private func labelMarker(text: String) -> some View {
        BPKText(text, style: .label2)
            .foregroundColor(configuration.markerTextColor)
            .padding(.vertical, .sm)
            .padding(.horizontal, .md)
            .padding(.bottom, markerFlareHeight)
            .background(configuration.markerBackgroundColor)
            .clipShape(LabelFlareShape(flareHeight: markerFlareHeight))
    }
    
    private func segmentLabels(segments: Segments) -> some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: geometry.size.width)
                    
                BPKText(segments.lower.text, style: .footnote)
                    .alignmentGuide(HorizontalAlignment.center) { viewDimensions in
                        viewDimensions[HorizontalAlignment.center] +
                        positionOffset(for: segments.lower.percentage, availableWidth: geometry.size.width)
                    }
                
                BPKText(segments.upper.text, style: .footnote)
                    .alignmentGuide(HorizontalAlignment.center) { viewDimensions in
                        viewDimensions[HorizontalAlignment.center] +
                        positionOffset(for: segments.upper.percentage, availableWidth: geometry.size.width)
                    }
            }
        }
        .frame(height: segmentLabelHeight)
    }
    
    private func leadingBarWidth(availableWidth: CGFloat) -> CGFloat {
        (configuration.lowerSegmentPercentage - configuration.min) *
        widthPerPercentagePoint(availableWidth: availableWidth)
    }
    
    private func middleBarWidth(availableWidth: CGFloat) -> CGFloat {
        (configuration.upperSegmentPercentage - configuration.lowerSegmentPercentage) *
        widthPerPercentagePoint(availableWidth: availableWidth)
    }
    
    private func trailingBarWidth(availableWidth: CGFloat) -> CGFloat {
        (configuration.max - configuration.upperSegmentPercentage) *
        widthPerPercentagePoint(availableWidth: availableWidth)
    }
    
    private func widthPerPercentagePoint(availableWidth: CGFloat) -> CGFloat {
        (availableWidth - barSpacing * 2) / configuration.range
    }
    
    private func positionOffset(for percentage: CGFloat, availableWidth: CGFloat) -> CGFloat {
        (configuration.mid - percentage) * availableWidth / configuration.range
    }
}

#Preview("Default") {
    VStack(spacing: .md) {
        BPKPriceRange(configuration: .default(.init(
            marker: .init(text: "£850", percentage: 85),
            segments: .init(
                lower: .init(text: "£200", percentage: 20),
                upper: .init(text: "£800", percentage: 80)
            )
        )))
        
        BPKPriceRange(configuration: .default(.init(
            marker: .init(text: "£500", percentage: 50),
            segments: .init(
                lower: .init(text: "£200", percentage: 20),
                upper: .init(text: "£800", percentage: 80)
            )
        )))
        
        BPKPriceRange(configuration: .default(.init(
            marker: .init(text: "£150", percentage: 15),
            segments: .init(
                lower: .init(text: "£200", percentage: 20),
                upper: .init(text: "£800", percentage: 80)
            )
        )))
    }
    .frame(width: 240)
}

#Preview("Collapsed") {
    VStack(spacing: .md) {
        BPKPriceRange(configuration: .collapsed(.init(
            markerPercentage: 90,
            segments: .init(
                lower: 20,
                upper: 80
            )
        )))
        
        BPKPriceRange(configuration: .collapsed(.init(
            markerPercentage: 50,
            segments: .init(
                lower: 20,
                upper: 80
            )
        )))
        
        BPKPriceRange(configuration: .collapsed(.init(
            markerPercentage: 10,
            segments: .init(
                lower: 20,
                upper: 80
            )
        )))
    }
    .frame(width: 140)
}

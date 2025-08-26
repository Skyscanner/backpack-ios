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

extension BPKPriceRange {
    public enum Configuration {
        case `default`(DefaultConfiguration)
        case collapsed(CollapsedConfiguration)
    }
    
    public struct DefaultConfiguration: Equatable {
        public let min: Double
        public let max: Double
        public let marker: Indicator
        public let segments: Segments
        
        public init(
            min: Double = 0,
            max: Double = 100,
            marker: Indicator,
            segments: Segments
        ) {
            self.min = min
            self.max = max
            self.marker = marker
            self.segments = segments
        }
    }
    
    public struct Segments: Equatable {
        public let lower: Indicator
        public let upper: Indicator
        public init(lower: Indicator, upper: Indicator) {
            self.lower = lower
            self.upper = upper
        }
    }
    
    public struct Indicator: Equatable {
        public let text: String
        public let percentage: Double
        
        public init(text: String, percentage: Double) {
            self.text = text
            self.percentage = percentage
        }
    }
    
    public struct CollapsedConfiguration: Equatable {
        public let min: Double
        public let max: Double
        public let markerPercentage: Double
        public let segments: CollapsedSegments
        
        public init(
            min: Double = 0,
            max: Double = 100,
            markerPercentage: Double,
            segments: CollapsedSegments
        ) {
            self.min = min
            self.max = max
            self.markerPercentage = markerPercentage
            self.segments = segments
        }
    }
    
    public struct CollapsedSegments: Equatable {
        public let lower: Double
        public let upper: Double
        public init(lower: Double, upper: Double) {
            self.lower = lower
            self.upper = upper
        }
    }
}

internal extension BPKPriceRange.Configuration {
    var min: Double {
        switch self {
        case .default(let config):
            return config.min
        case .collapsed(let config):
            return config.min
        }
    }
    
    var max: Double {
        switch self {
        case .default(let config):
            return config.max
        case .collapsed(let config):
            return config.max
        }
    }
    
    var mid: Double {
        (min + max) / 2
    }
    
    var range: Double {
        max - min
    }
    
    var barHeight: CGFloat {
        switch self {
        case .default:
            return BPKSpacing.md.value
        case .collapsed:
            return BPKSpacing.sm.value
        }
    }
    
    var lowerSegmentPercentage: Double {
        switch self {
        case .default(let config):
            return config.segments.lower.percentage
        case .collapsed(let config):
            return config.segments.lower
        }
    }
    
    var upperSegmentPercentage: Double {
        switch self {
        case .default(let config):
            return config.segments.upper.percentage
        case .collapsed(let config):
            return config.segments.upper
        }
    }
    
    var markerPercentage: Double {
        switch self {
        case .default(let config):
            return config.marker.percentage
        case .collapsed(let config):
            return config.markerPercentage
        }
    }
    
    var markerBackgroundColor: BPKColor {
        if markerPercentage < lowerSegmentPercentage {
            return .statusSuccessSpotColor
        } else if markerPercentage > upperSegmentPercentage {
            return .statusDangerSpotColor
        }
        return .corePrimaryColor
    }
    
    var markerTextColor: BPKColor {
        if markerPercentage < lowerSegmentPercentage || markerPercentage > upperSegmentPercentage {
            return .textPrimaryInverseColor
        }
        return .textOnDarkColor
    }
    
    var markerHeight: CGFloat {
        switch self {
        case .default:
            return 30
        case .collapsed:
            return 12
        }
    }
}

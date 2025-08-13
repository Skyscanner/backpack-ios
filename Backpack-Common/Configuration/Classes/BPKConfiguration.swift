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

public final class BpkConfiguration {
    /// Shared singleton instance
    public static let shared = BpkConfiguration()
    
    private init() {}
    
    /// Checking for previous config setting
    private var hasSet = false
    
    enum ConfigurationError: Error {
        case configAlreadySet
    }
    
    public enum RadiusToken {
        case roundCorners
    }
    
    /// Configuration for the Chip component
    public struct BpkButtonConfig {
        var size: CGFloat?
        var colorName: String?
    }
    
    public struct BpkTextConfig {
        var fontName: String?
    }
    
    public struct BpkCardConfig {
        var cornerRadius: CGFloat?
    }
    
    public struct BpkChipConfig {
        public var color: Color?
        public var height: CGFloat?
        public var heightDimension: String?
        public var radius: CGFloat?
        public var radiusToken: RadiusToken?
    }
    
    /// Setting stored configs
    public var chipConfig: BpkChipConfig?
    public var buttonConfig: BpkButtonConfig?
    public var textConfig: BpkTextConfig?
    public var cardConfig: BpkCardConfig?
    
    public func set(
        chipConfig: Bool = false,
        buttonConfig: Bool = false,
        textConfig: Bool = false,
        cardConfig: Bool = false
    ) {
        guard !hasSet else {
            // throw ConfigurationError.configAlreadySet
            return
        }
        hasSet = true
        
        /// Example experiment configs
        if chipConfig {
            self.chipConfig = BpkChipConfig(
                color: .accentColor,
                height: 12,
                heightDimension: "bpk_new_chip_height",
                radius: 100,
                radiusToken: .roundCorners
            )
        }
    }
}

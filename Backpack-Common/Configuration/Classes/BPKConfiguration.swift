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
import Foundation
// swiftlint:disable line_length

public final class BpkConfiguration {
    /// Shared singleton instance
    public static let shared = BpkConfiguration()
    
    private init() {}
    
    /// Checking for previous config setting
    private var hasSet = false
    
    // Tracking if any configuration has been accessed
    private var configIsAccessed: Bool = false
    private let configurationAccessQueue = DispatchQueue(label: "com.backpack.configuration.access", attributes: .concurrent)
    
    // Callback for configuration access
    public var onConfigurationAccessed: (() -> Void)?
    
    enum ConfigurationError: Error {
        case configAlreadySet
    }
    
    public enum RadiusToken {
        case roundCorners
    }
    
    /// Component configurations
    public struct BpkButtonConfig {}
    
    public struct TypographyConfig {
        public var font: Font?
        public var fontFixed: Font?
        public var letterSpacing: CGFloat?
        public var size: CGFloat?
    }
    
    public struct BpkCardConfig {}
    
    public struct BpkChipConfig {
        public var color: Color?
        public var height: CGFloat?
        public var heightDimension: String?
        public var radius: CGFloat?
        public var radiusToken: RadiusToken?
    }
    
    /// Setting stored configs
    private var _chipConfig: BpkChipConfig?
    
    public var chipConfig: BpkChipConfig? {
        get { getConfig { self._chipConfig } }
        set { _chipConfig = newValue }
    }
    
    private var _typographyConfig: TypographyConfig?
    private var _heading1Config: TypographyConfig?
    private var _heading2Config: TypographyConfig?
    private var _heading3Config: TypographyConfig?
    private var _heading4Config: TypographyConfig?
    private var _heading5Config: TypographyConfig?
    private var _hero5Config: TypographyConfig?
    
    public var typographyConfig: TypographyConfig? {
        get { getConfig { self._typographyConfig } }
        set { _typographyConfig = newValue }
    }
    
    public var hero5Config: TypographyConfig? {
        get { getConfig { self._hero5Config } }
        set { _hero5Config = newValue }
    }
    
    public var heading1Config: TypographyConfig? {
        get { getConfig { self._heading1Config } }
        set { _heading1Config = newValue }
    }
    
    public var heading2Config: TypographyConfig? {
        get { getConfig { self._heading2Config } }
        set { _heading2Config = newValue }
    }
    
    public var heading3Config: TypographyConfig? {
        get { getConfig { self._heading3Config } }
        set { _heading3Config = newValue }
    }
    
    public var heading4Config: TypographyConfig? {
        get { getConfig { self._heading4Config } }
        set { _heading4Config = newValue }
    }
    
    public var heading5Config: TypographyConfig? {
        get { getConfig { self._heading5Config } }
        set { _heading5Config = newValue }
    }
    
    private func getConfig<T>(getter: () -> T) -> T {
        emitSignalIfNeeded()
        return configurationAccessQueue.sync {
            getter()
        }
    }
    
    private func emitSignalIfNeeded() {
        configurationAccessQueue.async(flags: .barrier) {
            if !self.configIsAccessed {
                self.configIsAccessed = true
                self.onConfigurationAccessed?()
            }
        }
    }
    
    public func set(
        chipConfig: Bool = false,
        typographyConfig: Bool = false
    ) throws {
        guard !hasSet else {
            throw ConfigurationError.configAlreadySet
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
        
        if typographyConfig {
            self.hero5Config = TypographyConfig(
                letterSpacing: -1.2
            )
            
            self.heading1Config = TypographyConfig(
                letterSpacing: -1.2
            )
            
            self.heading2Config = TypographyConfig(
                letterSpacing: -1
            )
            
            self.heading3Config = TypographyConfig(
                letterSpacing: -0.6
            )
            
            self.heading4Config = TypographyConfig(
                letterSpacing: -0.6
            )
            
            self.heading5Config = TypographyConfig(
                letterSpacing: -0.6
            )
        }
    }
}

extension BpkConfiguration {
    public func reset() {
        chipConfig = nil
        hasSet = false
        configIsAccessed = false
        onConfigurationAccessed = nil
    }
}

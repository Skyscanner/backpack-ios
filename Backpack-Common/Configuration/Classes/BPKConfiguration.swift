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

@objcMembers
public final class BpkConfiguration: NSObject {
    /// Shared singleton instance
    public static let shared = BpkConfiguration()
    
    private override init() {}
    
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
    
    public struct BpkCardConfig {}
    
    public struct BpkChipConfig {
        public var color: UIColor?
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
    
    private var _typographyConfigSet: Bool = false
    @objc private var _heading1Config: TypographyConfig?
    @objc private var _heading2Config: TypographyConfig?
    @objc private var _heading3Config: TypographyConfig?
    @objc private var _heading4Config: TypographyConfig?
    @objc private var _heading5Config: TypographyConfig?
    @objc private var _hero5Config: TypographyConfig?
    
    public var typographyConfigSet: Bool {
        get { getConfig { self._typographyConfigSet } }
        set { _typographyConfigSet = newValue }
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
    
    private func setChipExperiment(chipConfig: Bool) {
        
        // To add to foundations.
        let onFillLight = UIColor(red: 21/255, green: 70/255, blue: 121/255, alpha: 1)
        let onFillDark = UIColor(red: 2/255, green: 77/255, blue: 175/255, alpha: 1)
        let chipOnDarkFill = UIColor.dynamicColorTest(light: onFillLight, dark: onFillDark)
        
        /// Example experiment configs
        if chipConfig {
            self.chipConfig = BpkChipConfig(
                color: chipOnDarkFill,
                height: 8,
                heightDimension: "bpk_new_chip_height",
                radius: 100,
                radiusToken: .roundCorners
            )
        }
    }
    
    private func setTypographyExperiment(typographyConfig: Bool) {
        if typographyConfig {
            
            self.typographyConfigSet = true
            
            self.hero5Config = TypographyConfig(
                font: Font.blackUIFont(size: 48, style: .title2),
                fontFixed: Font.blackUIFont(size: 48, style: .title2),
                letterSpacing: -1.2
            )
            
            self.heading1Config = TypographyConfig(
                font: Font.blackUIFont(size: 40, style: .title2),
                fontFixed: Font.blackUIFont(size: 40, style: .title2),
                letterSpacing: -1.2
            )
            
            self.heading2Config = TypographyConfig(
                font: Font.blackUIFont(size: 32, style: .title2),
                fontFixed: Font.blackUIFont(size: 32, style: .title2),
                letterSpacing: -1
            )
            
            self.heading3Config = TypographyConfig(
                font: Font.blackUIFont(size: 24, style: .title3),
                fontFixed: Font.blackUIFont(size: 24, style: .title3),
                letterSpacing: -0.6
            )
            
            self.heading4Config = TypographyConfig(
                font: Font.blackUIFont(size: 20, style: .title3),
                fontFixed: Font.blackUIFont(size: 48, style: .title3),
                letterSpacing: -0.6
            )
            
            self.heading5Config = TypographyConfig(
                font: Font.blackUIFont(size: 16, style: .title2),
                fontFixed: Font.blackUIFont(size: 16, style: .title2),
                letterSpacing: -0.6
            )
        }
    }
    
    public func font(_ token: TypographyTokenConfig?, defaultFont: Font, fixed: Bool) -> Font {
        
        if typographyConfigSet {
            switch token {
            case .heading1Config:
                return fixed ? .blackFixed(size: 40) : .black(size: 40, textStyle: .title2)
            case .heading2Config:
                return fixed ? .blackFixed(size: 32) : .black(size: 32, textStyle: .title2)
            case .heading3Config:
                return fixed ? .blackFixed(size: 24) : .black(size: 24, textStyle: .title3)
            case .heading4Config:
                return fixed ? .blackFixed(size: 20) : .black(size: 20, textStyle: .title3)
            case .heading5Config:
                return fixed ? .blackFixed(size: 16) : .black(size: 16, textStyle: .title3)
            case .hero5Config:
                return fixed ? .blackFixed(size: 48) : .black(size: 48, textStyle: .largeTitle)
            case .none:
                return defaultFont
            }
        }
        
        return defaultFont
    }
    
    public func set(
        chipConfig: Bool = false,
        typographyConfig: Bool = false
    ) throws {
        guard !hasSet else {
            throw ConfigurationError.configAlreadySet
        }
        hasSet = true
        
        setChipExperiment(chipConfig: chipConfig)
        
        setTypographyExperiment(typographyConfig: typographyConfig)
    }
}

public enum TypographyTokenConfig {
    case heading1Config
    case heading2Config
    case heading3Config
    case heading4Config
    case heading5Config
    case hero5Config
}

@objcMembers
public class TypographyConfig: NSObject {
    public var font: UIFont?
    public var fontFixed: UIFont?
    public var letterSpacing: CGFloat = 0
    public var size: CGFloat = 0
    
    init(
        font: UIFont? = nil,
        fontFixed: UIFont? = nil,
        letterSpacing: CGFloat = 0,
        size: CGFloat = 0
    ) {
        self.font = font
        self.fontFixed = fontFixed
        self.letterSpacing = letterSpacing
        self.size = size
    }
}

extension BpkConfiguration {
    public func reset() {
        heading1Config = nil
        heading2Config = nil
        heading3Config = nil
        heading4Config = nil
        heading5Config = nil
        typographyConfigSet = false
        chipConfig = nil
        hasSet = false
        configIsAccessed = false
        onConfigurationAccessed = nil
    }
}

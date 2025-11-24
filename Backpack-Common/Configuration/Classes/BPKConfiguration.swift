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

public enum ConfigType: String {
    case chips = "backpack_chips"
    case typography = "backpack_experiment"
    case badge = "backpack_badge"
    case button = "backpack_button"
    case card = "backpack_card"
    case icon = "backpack_icon"
    case all = "backpack_all"
}

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
    public struct BpkButtonConfig {
        public var radius: CGFloat?
        public var height: CGFloat?
        public var secondaryButtonBackgroundColour: UIColor?
        public var secondaryButtonForegroundColour: UIColor?
        public var secondaryButtonPressedBackgroundColour: UIColor?
        public var setFontLabel2: Bool?
    }
    
    private var _buttonConfig: BpkButtonConfig?
    
    public var buttonConfig: BpkButtonConfig? {
        get { getConfig { self._buttonConfig } }
        set { _buttonConfig = newValue }
    }
    
    public struct BpkBadgeConfig {}

    public struct BpkCardConfig {}
    
    public struct BpkChipConfig {
        public var color: UIColor?
        public var height: CGFloat?
        public var heightDimension: String?
        public var radius: CGFloat?
        public var radiusToken: RadiusToken?
    }
    
    public struct BpkIconConfig {
        public var setBpkIcon: Bool?
    }
    
    /// Setting stored configs
    private var _badgeConfig: BpkBadgeConfig?

    public var badgeConfig: BpkBadgeConfig? {
        get { getConfig { self._badgeConfig } }
        set { _badgeConfig = newValue }
    }

    private var _chipConfig: BpkChipConfig?
    
    public var chipConfig: BpkChipConfig? {
        get { getConfig { self._chipConfig } }
        set { _chipConfig = newValue }
    }
    
    private var _cardConfig: BpkCardConfig?

    public var cardConfig: BpkCardConfig? {
        get { getConfig { self._cardConfig } }
        set { _cardConfig = newValue }
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
    
    private var _iconConfig: BpkIconConfig?

    public var iconConfig: BpkIconConfig? {
        get { getConfig { self._iconConfig } }
        set { _iconConfig = newValue }
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
    
    private func setButtonExperiment() {
        let secondaryLight = UIColor(red: 0.890, green: 0.941, blue: 1.000, alpha: 1.0)
        let secondaryDark = UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1.0)
        let buttonBackgroundColour = UIColor.dynamicColorTest(light: secondaryLight, dark: secondaryDark)
        
        let secondaryForegroundLight = UIColor(red: 2/255, green: 77/255, blue: 175/255, alpha: 1.0)
        let secondaryForegroundDark = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        let buttonForegroundColour = UIColor.dynamicColorTest(light: secondaryForegroundLight, dark: secondaryForegroundDark)
        
        let pressedBackgroundLight = UIColor(red: 180/255, green: 215/255, blue: 255/255, alpha: 1.0)
        let pressedBackgroundDark = UIColor(red: 68/255, green: 80/255, blue: 95/255, alpha: 1.0)
        let pressedBackgroundColour = UIColor.dynamicColorTest(light: pressedBackgroundLight, dark: pressedBackgroundDark)
        
        self.buttonConfig = BpkButtonConfig(radius: 100.0, height: 56, secondaryButtonBackgroundColour: buttonBackgroundColour, secondaryButtonForegroundColour: buttonForegroundColour, secondaryButtonPressedBackgroundColour: pressedBackgroundColour, setFontLabel2: true)
    }
    
    private func setCardExperiment() {
        self.cardConfig = BpkCardConfig()
    }
    
    private func setChipExperiment() {
        let onFillLight = UIColor(red: 21/255, green: 70/255, blue: 121/255, alpha: 1)
        let onFillDark = UIColor(red: 2/255, green: 77/255, blue: 175/255, alpha: 1)
        let chipOnDarkFill = UIColor.dynamicColorTest(light: onFillLight, dark: onFillDark)
        
        self.chipConfig = BpkChipConfig(
            color: chipOnDarkFill,
            height: 8,
            heightDimension: "bpk_new_chip_height",
            radius: 100,
            radiusToken: .roundCorners
        )
    }

    private func setBadgeExperiment() {
        self.badgeConfig = BpkBadgeConfig()
    }
    
    private func setIconExperiment() {
        self.iconConfig = BpkIconConfig(setBpkIcon: true)
    }

    private func setTypographyExperiment() {
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
    
    public func set(configs: [ConfigType]) throws {
        guard !hasSet else {
            throw ConfigurationError.configAlreadySet
        }
        hasSet = true
        
        for config in configs {
            switch config {
            case .all:
                setAllConfigs()
            case .chips:
                setChipExperiment()
            case .typography:
                setTypographyExperiment()
            case .badge:
                setBadgeExperiment()
            case .button:
                setButtonExperiment()
            case .card:
                setCardExperiment()
            case .icon:
                setIconExperiment()
            }
        }
    }
    
    func setAllConfigs() {
        setChipExperiment()
        setTypographyExperiment()
        setBadgeExperiment()
        setButtonExperiment()
        setCardExperiment()
        setIconExperiment()
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
        buttonConfig = nil
        badgeConfig = nil
        cardConfig = nil
        iconConfig = nil
        hasSet = false
        configIsAccessed = false
        onConfigurationAccessed = nil
    }
}

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
    
    @objc private var _typographyConfig: TypographyConfig?
    @objc private var _heading1Config: TypographyConfig?
    @objc private var _heading2Config: TypographyConfig?
    @objc private var _heading3Config: TypographyConfig?
    @objc private var _heading4Config: TypographyConfig?
    @objc private var _heading5Config: TypographyConfig?
    @objc private var _hero5Config: TypographyConfig?
    
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
    
    private func setTypographyExperiment(typographyConfig: Bool) {
        if typographyConfig {
            self.hero5Config = TypographyConfig(
                font: .toUIFont(
                    font: .black(size: 48, textStyle: .largeTitle)
                ),
                fontFixed: .toUIFont(
                    font: .blackFixed(size: 48)),
                letterSpacing: -1.2
            )
            
            self.heading1Config = TypographyConfig(
                letterSpacing: -1.2
            )
            
            self.heading2Config = TypographyConfig(
                font: .toUIFont(
                    font: .black(size: 32, textStyle: .title2)
                ),
                fontFixed: .toUIFont(
                    font: .blackFixed(size: 32)),
                letterSpacing: -1
            )
            
            self.heading3Config = TypographyConfig(
                font: .toUIFont(
                    font: .black(size: 24, textStyle: .title3)
                ),
                fontFixed: .toUIFont(
                    font: .blackFixed(size: 24)),
                letterSpacing: -0.6
            )
            
            self.heading4Config = TypographyConfig(
                font: .toUIFont(
                    font: .black(size: 20, textStyle: .title3)
                ),
                fontFixed: .toUIFont(
                    font: .blackFixed(size: 20)),
                letterSpacing: -0.6
            )
            
            self.heading5Config = TypographyConfig(
                font: .toUIFont(
                    font: .black(size: 16, textStyle: .title3)
                ),
                fontFixed: .toUIFont(
                    font: .blackFixed(size: 16)),
                letterSpacing: -0.6
            )
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
        
        setTypographyExperiment(typographyConfig: typographyConfig)
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
    
    public func getFont(isFixed: Bool) -> Font? {
        if let font = self.font, isFixed, let fontFixed = self.fontFixed {
            if isFixed {
                return Font(fontFixed)
            } else {
                return Font(font)
            }
        }
        return nil
    }
}

extension Font {
    var textStyleMapping: UIFont.TextStyle {
        switch self {
        case Font.largeTitle:
            .largeTitle
        case Font.title:
            .title1
        case Font.title2:
            .title2
        case Font.title3:
            .title3
        case Font.headline:
            .headline
        case Font.subheadline:
            .subheadline
        case Font.callout:
            .callout
        case Font.caption:
            .caption1
        case Font.caption2:
            .caption2
        case Font.footnote:
            .footnote
        default:
            .body
        }
    }
}

extension UIFont {
    class func toUIFont(font: Font) -> UIFont {
        return UIFont.preferredFont(forTextStyle: font.textStyleMapping)
    }
}

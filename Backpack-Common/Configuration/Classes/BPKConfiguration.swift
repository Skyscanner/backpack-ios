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
    public static var shared = BpkConfiguration()
    
    private init() {}
    
    /// Checking for previous config setting
    private var hasSet = false
    
    public static func reset() {
        shared = BpkConfiguration()
    }
    
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
    
    /// Configuration for the Chip component
    public struct BpkButtonConfig {
        public var height: CGFloat?
        public var heightDimension: String?
        public var color: Color?
        public var radius: CGFloat?
        public var radiusToken: RadiusToken?
    }
    
    public struct BpkTextConfig {
        public var font: Font?
        public var fontFixed: Font?
        public var letterSpacing: CGFloat?
        public var size: CGFloat?
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
    private var _chipConfig: BpkChipConfig?
    private var _buttonConfig: BpkButtonConfig?
    private var _textConfig: BpkTextConfig?
    private var _cardConfig: BpkCardConfig?
    
    public var chipConfig: BpkChipConfig? {
        get { getConfig { self._chipConfig } }
        set { _chipConfig = newValue }
    }
    
    public var buttonConfig: BpkButtonConfig? {
        get { getConfig { self._buttonConfig } }
        set { _buttonConfig = newValue }
    }
    
    public var textConfig: BpkTextConfig? {
        get { getConfig { self._textConfig } }
        set { _textConfig = newValue }
    }
    
    public var cardConfig: BpkCardConfig? {
        get { getConfig { self._cardConfig } }
        set { _cardConfig = newValue }
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
        buttonConfig: Bool = false,
        textConfig: Bool = false,
        cardConfig: Bool = false
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
        
        if buttonConfig {
            self.buttonConfig = BpkButtonConfig(
                height: 24,
                heightDimension: "bpk_new_button_height",
                color: .green,
                radius: 100,
                radiusToken: .roundCorners
            )
        }
        
        if textConfig {
            self.textConfig = BpkTextConfig(
                font: .caption2,
                fontFixed: .caption2,
                letterSpacing: 10,
                size: 100
            )
        }
    }
}

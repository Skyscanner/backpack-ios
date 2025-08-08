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

/// Protocol defining the interface for managing Backpack component configurations.
/// Allows setting, retrieving, and resetting configuration sets for different components.
public protocol BPKConfigurationProtocol {
    /// Sets configuration values for multiple components at once
    /// - Parameter values: A dictionary mapping components to their configuration sets
    func set(_ values: [BPKComponent: BPKConfigSet])
    
    /// Retrieves the configuration set for a specific component
    /// - Parameter component: The component to retrieve configuration for
    /// - Returns: The configuration set for the component, or nil if not found
    func config(for component: BPKComponent) -> BPKConfigSet?
    
    /// Clears all component configurations
    func reset()
}

/// Enum representing different Backpack components that can be configured
public enum BPKComponent: String, Hashable {
    /// Global configuration affecting all components
    case global
    
    /// Configuration for the Chip component
    case bpkChip
}

/// A configuration set containing theming values for fonts, colors, spacing, etc.
public struct BPKConfigSet {
    /// SwiftUI fonts configuration
    public var fonts: [String: Font]
    
    /// UIKit fonts configuration (legacy support)
    public var fontsLegacy: [String: UIFont]
    
    /// SwiftUI colors configuration
    public var colors: [String: Color]
    
    /// UIKit colors configuration (legacy support)
    public var colorsLegacy: [String: UIColor]
    
    /// Spacing values configuration
    public var spacings: [String: CGFloat]
    
    /// Component name mappings
    public var names: [String: String]
    
    /// Behavioral flags configuration
    public var behaviours: [String: Bool]

    /// Creates a new configuration set with optional initial values
    /// - Parameters:
    ///   - fonts: SwiftUI fonts dictionary
    ///   - fontsLegacy: UIKit fonts dictionary
    ///   - colors: SwiftUI colors dictionary
    ///   - colorsLegacy: UIKit colors dictionary
    ///   - spacings: Spacing values dictionary
    ///   - names: Component names dictionary
    ///   - behaviours: Behavioral flags dictionary
    public init(
        fonts: [String: Font] = [:],
        fontsLegacy: [String: UIFont] = [:],
        colors: [String: Color] = [:],
        colorsLegacy: [String: UIColor] = [:],
        spacings: [String: CGFloat] = [:],
        names: [String: String] = [:],
        behaviours: [String: Bool] = [:]
    ) {
        self.fonts = fonts
        self.fontsLegacy = fontsLegacy
        self.colors = colors
        self.colorsLegacy = colorsLegacy
        self.spacings = spacings
        self.names = names
        self.behaviours = behaviours
    }
}

// MARK: - Implementation

/// Singleton class implementing the configuration protocol for Backpack components
public final class BPKConfiguration: BPKConfigurationProtocol {
    /// Storage for component-specific configurations
    private var perComponent: [BPKComponent: BPKConfigSet] = [:]
    
    /// Shared singleton instance
    public static let shared = BPKConfiguration()

    private init() {}

    public func set(_ values: [BPKComponent: BPKConfigSet]) {
        BPKConfiguration.shared.perComponent = values
    }

    public func config(for component: BPKComponent) -> BPKConfigSet? {
        return BPKConfiguration.shared.perComponent[component]
    }

    public func reset() {
        BPKConfiguration.shared.perComponent.removeAll()
    }
}

// MARK: - Helper
extension BPKConfiguration {
    /// Accesses the global configuration set
    var global: BPKConfigSet {
        BPKConfiguration.shared.config(for: .global) ?? .globalDefault
    }
}

extension BPKConfigSet {
    /// Default global configuration with empty values
    public static let globalDefault = BPKConfigSet(
        fonts: [:],
        fontsLegacy: [:],
        colors: [:],
        colorsLegacy: [:],
        spacings: [:],
        names: [:],
        behaviours: [:]
    )
}

public extension BPKConfigSet {
    /// Helper to retrieve configuration for a component, with optional override
    /// - Parameters:
    ///   - componentName: Component to retrieve configuration for
    ///   - override: Optional override configuration
    /// - Returns: Configuration set for the component
    static func setFor(
        _ componentName: BPKComponent,
        override: BPKConfigSet? = nil
    ) -> BPKConfigSet? {
        return override ?? BPKConfiguration.shared.config(for: componentName)
    }
}

// MARK: - Helper for dictate the layer of configuration

public extension Optional where Wrapped == BPKConfigSet {
    /// Retrieves a font value with fallback chain: component > default > global > system fallback
    /// - Parameters:
    ///   - key: The configuration key
    ///   - default: Optional default value
    /// - Returns: The resolved font value
    func font(for key: String, _ `default`: Font? = nil) -> Font {
        getValue(
            key: key,
            from: \.fonts,
            default: `default`,
            fallback: .body
        )
    }

    /// Retrieves a UIKit font value with fallback chain: component > default > global > system fallback
    /// - Parameters:
    ///   - key: The configuration key
    ///   - default: Optional default value
    /// - Returns: The resolved UIKit font value
    func fontLegacy(for key: String, _ `default`: UIFont? = nil) -> UIFont {
        getValue(
            key: key,
            from: \.fontsLegacy,
            default: `default`,
            fallback: .boldSystemFont(ofSize: 10)
        )
    }

    /// Retrieves a color value with fallback chain: component > default > global > system fallback
    /// - Parameters:
    ///   - key: The configuration key
    ///   - default: Optional default value
    /// - Returns: The resolved color value
    func color(for key: String, _ `default`: Color? = nil) -> Color {
        getValue(
            key: key,
            from: \.colors,
            default: `default`,
            fallback: .black
        )
    }

    /// Retrieves a UIKit color value with fallback chain: component > default > global > system fallback
    /// - Parameters:
    ///   - key: The configuration key
    ///   - default: Optional default value
    /// - Returns: The resolved UIKit color value
    func colorLegacy(for key: String, _ `default`: UIColor? = nil) -> UIColor {
        getValue(
            key: key,
            from: \.colorsLegacy,
            default: `default`,
            fallback: .black
        )
    }

    /// Retrieves a spacing value with fallback chain: component > default > global > zero
    /// - Parameters:
    ///   - key: The configuration key
    ///   - default: Optional default value
    /// - Returns: The resolved spacing value
    func spacing(for key: String, _ `default`: CGFloat? = nil) -> CGFloat {
        getValue(
            key: key,
            from: \.spacings,
            default: `default`,
            fallback: 0
        )
    }

    /// Retrieves a name value with fallback chain: component > default > global > empty string
    /// - Parameters:
    ///   - key: The configuration key
    ///   - default: Optional default value
    /// - Returns: The resolved name value
    func name(for key: String, _ `default`: String? = nil) -> String {
        getValue(
            key: key,
            from: \.names,
            default: `default`,
            fallback: ""
        )
    }

    /// Retrieves a behavior flag with fallback chain: component > default > global > false
    /// - Parameters:
    ///   - key: The configuration key
    ///   - default: Optional default value
    /// - Returns: The resolved behavior value
    func behaviour(for key: String, _ `default`: Bool? = nil) -> Bool {
        getValue(
            key: key,
            from: \.behaviours,
            default: `default`,
            fallback: false
        )
    }
}

private extension Optional where Wrapped == BPKConfigSet {
    private func getValue<T>(
        key: String,
        from dict: (BPKConfigSet) -> [String: T]?,
        `default`: T?,
        fallback: T
    ) -> T {
        let output = self.flatMap { dict($0)?[key] }
        ?? `default`
        ?? dict(BPKConfiguration.shared.global)?[key]

        if let output {
            return output
        } else {
            assertionFailure("No value defined for `\(key)` in \(String(describing: self))")
            return fallback
        }
    }
}
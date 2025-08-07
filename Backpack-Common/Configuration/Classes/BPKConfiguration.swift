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

public protocol BPKConfigurationProtocol {
    func set(_ values: [BPKComponent: BPKConfigSet])
    func config(for component: BPKComponent) -> BPKConfigSet?
    func reset()
}

public enum BPKComponent: String, Hashable {
    case global
    case bpkChip
}

public struct BPKConfigSet {
    public var fonts: [String: Font]
    public var fontsLegacy: [String: UIFont] // UIKit Fonts
    public var colors: [String: Color]
    public var colorsLegacy: [String: UIColor] // UIKit Colour
    public var spacings: [String: CGFloat]
    public var names: [String: String]
    public var behaviours: [String: Bool]

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

public final class BPKConfiguration: BPKConfigurationProtocol {
    private var perComponent: [BPKComponent: BPKConfigSet] = [:]
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
    var global: BPKConfigSet {
        BPKConfiguration.shared.config(for: .global) ?? .globalDefault
    }
}

extension BPKConfigSet {
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
    static func setFor(
        _ componentName: BPKComponent,
        override: BPKConfigSet? = nil
    ) -> BPKConfigSet? {
        return override ?? BPKConfiguration.shared.config(for: componentName)
    }
}

// MARK: - Helper for dictate the layer of configuration

public extension Optional where Wrapped == BPKConfigSet {
    func font(for key: String, _ `default`: Font? = nil) -> Font {
        getValue(
            key: key,
            from: \.fonts,
            default: `default`,
            fallback: .body
        )
    }

    func fontLegacy(for key: String, _ `default`: UIFont? = nil) -> UIFont {
        getValue(
            key: key,
            from: \.fontsLegacy,
            default: `default`,
            fallback: .boldSystemFont(ofSize: 10)
        )
    }

    func color(for key: String, _ `default`: Color? = nil) -> Color {
        getValue(
            key: key,
            from: \.colors,
            default: `default`,
            fallback: .black
        )
    }

    func colorLegacy(for key: String, _ `default`: UIColor? = nil) -> UIColor {
        getValue(
            key: key,
            from: \.colorsLegacy,
            default: `default`,
            fallback: .black
        )
    }

    func spacing(for key: String, _ `default`: CGFloat? = nil) -> CGFloat {
        getValue(
            key: key,
            from: \.spacings,
            default: `default`,
            fallback: 0
        )
    }

    func name(for key: String, _ `default`: String? = nil) -> String {
        getValue(
            key: key,
            from: \.names,
            default: `default`,
            fallback: ""
        )
    }

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

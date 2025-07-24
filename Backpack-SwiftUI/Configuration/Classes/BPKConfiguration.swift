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
    var global: BPKConfigSet { get set }
    var perComponent: [BPKComponent: BPKConfigSet] { get set }
}

public enum BPKComponent: String, Hashable {
    case global
    case bpkButton
    case bpkText
    case bpkCard
}

public struct BPKConfigSet {
    public var fonts: [String: Font]
    public var colors: [String: Color]
    public var spacings: [String: CGFloat]
    public var names: [String: String]
    public var behaviours: [String: Bool]
}

// MARK: - Helper for dictate the layer of configuration

public extension BPKConfigurationProtocol {

    func resolveFont(for key: String, in component: BPKComponent, fallback: Font) -> Font {
        return perComponent[component]?.fonts[key]
            ?? global.fonts[key]
            ?? fallback
    }

    func resolveColor(for key: String, in component: BPKComponent, fallback: Color) -> Color {
        return perComponent[component]?.colors[key]
            ?? global.colors[key]
            ?? fallback
    }

    func resolveSpacing(for key: String, in component: BPKComponent, fallback: CGFloat) -> CGFloat {
        return perComponent[component]?.spacings[key]
            ?? global.spacings[key]
            ?? fallback
    }

    func resolveName(for key: String, in component: BPKComponent, fallback: String) -> String {
        return perComponent[component]?.names[key]
            ?? global.names[key]
            ?? fallback
    }

    func resolveBehaviour(for key: String, in component: BPKComponent, fallback: Bool) -> Bool {
        return perComponent[component]?.behaviours[key]
            ?? global.behaviours[key]
            ?? fallback
    }
}

// MARK: - Implementation

public final class BPKConfiguration: BPKConfigurationProtocol {
    public var global: BPKConfigSet = .globalDefault
    public var perComponent: [BPKComponent: BPKConfigSet] = [:]

    public static let shared = BPKConfiguration()

    private init() {}

    public func set(_ config: BPKConfigSet, for component: BPKComponent) {
        perComponent[component] = config
    }

    public func config(for component: BPKComponent) -> BPKConfigSet {
        return perComponent[component]!
    }
}

extension BPKConfigSet {
    public static let globalDefault = BPKConfigSet(
        fonts: [:],
        colors: [:],
        spacings: [:],
        names: [:],
        behaviours: [:]
    )
}

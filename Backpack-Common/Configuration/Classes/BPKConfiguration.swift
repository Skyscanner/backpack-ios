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

import Foundation

public enum ConfigType: String {
    /// Presents the modal bottom sheet as a native sheet.
    case nativeBottomSheet = "backpack_native_bottom_sheet"
}

@objcMembers
public final class BpkConfiguration: NSObject {
    /// Shared singleton instance.
    public static let shared = BpkConfiguration()

    private override init() {}

    private var hasSet = false
    private var configIsAccessed = false
    private let configurationAccessQueue = DispatchQueue(label: "com.backpack.configuration.access", attributes: .concurrent)

    /// Called once when an experimental configuration is first accessed.
    public var onConfigurationAccessed: (() -> Void)?

    enum ConfigurationError: Error {
        case configAlreadySet
    }

    public struct BpkBottomSheetConfig {
        /// The modal bottom sheet is presented as a native sheet instead of the floating panel.
        public var nativeModalSheet: Bool?
    }

    private var _bottomSheetConfig: BpkBottomSheetConfig?

    public var bottomSheetConfig: BpkBottomSheetConfig? {
        get {
            emitSignalIfNeeded()
            return _bottomSheetConfig
        }
        set { _bottomSheetConfig = newValue }
    }

    private func emitSignalIfNeeded() {
        configurationAccessQueue.async(flags: .barrier) {
            if !self.configIsAccessed {
                self.configIsAccessed = true
                self.onConfigurationAccessed?()
            }
        }
    }

    /// Applies the selected experiments once, until the configuration is reset.
    public func set(configs: [ConfigType]) throws {
        guard !hasSet else {
            throw ConfigurationError.configAlreadySet
        }
        hasSet = true

        for config in configs {
            switch config {
            case .nativeBottomSheet:
                bottomSheetConfig = BpkBottomSheetConfig(nativeModalSheet: true)
            }
        }
    }

    /// Restores the default behaviour and allows another experiment allocation.
    public func reset() {
        bottomSheetConfig = nil
        hasSet = false
        configIsAccessed = false
        onConfigurationAccessed = nil
    }
}

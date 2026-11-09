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
    private var accessGeneration: UInt64 = 0
    private let configurationLock = NSLock()
    private let configurationAccessQueue = DispatchQueue(label: "com.backpack.configuration.access")
    private var _onConfigurationAccessed: (() -> Void)?

    /// Called asynchronously once on a private background queue when ``bottomSheetConfig`` is first read,
    /// even if no experiment is enabled. Perform UI updates on the main actor.
    /// Resetting clears the callback and allows another access notification.
    public var onConfigurationAccessed: (() -> Void)? {
        get { withConfigurationLock { _onConfigurationAccessed } }
        set { withConfigurationLock { _onConfigurationAccessed = newValue } }
    }

    /// Errors raised when allocating experiments.
    public enum ConfigurationError: Error, Equatable {
        /// Experiments have already been allocated. Reset before allocating again.
        case configAlreadySet
    }

    public struct BpkBottomSheetConfig {
        /// The modal bottom sheet is presented as a native sheet instead of the floating panel.
        public var nativeModalSheet: Bool?
    }

    private var _bottomSheetConfig: BpkBottomSheetConfig?

    public var bottomSheetConfig: BpkBottomSheetConfig? {
        get {
            withConfigurationLock {
                if !configIsAccessed {
                    configIsAccessed = true
                    let generation = accessGeneration
                    configurationAccessQueue.async {
                        let callback: (() -> Void)? = self.withConfigurationLock {
                            guard generation == self.accessGeneration else { return nil }
                            return self._onConfigurationAccessed
                        }
                        // Consumer callbacks may access or reset configuration, so run them outside the lock.
                        callback?()
                    }
                }
                return _bottomSheetConfig
            }
        }
        set { withConfigurationLock { _bottomSheetConfig = newValue } }
    }

    /// Applies the selected experiments once, until the configuration is reset.
    public func set(configs: [ConfigType]) throws {
        try withConfigurationLock {
            guard !hasSet else {
                throw ConfigurationError.configAlreadySet
            }
            hasSet = true

            for config in configs {
                switch config {
                case .nativeBottomSheet:
                    _bottomSheetConfig = BpkBottomSheetConfig(nativeModalSheet: true)
                }
            }
        }
    }

    /// Restores the default behaviour and allows another experiment allocation.
    /// Clears the callback and invalidates pending notifications from the previous allocation.
    public func reset() {
        withConfigurationLock {
            _bottomSheetConfig = nil
            hasSet = false
            configIsAccessed = false
            _onConfigurationAccessed = nil
            accessGeneration &+= 1
        }
    }

    private func withConfigurationLock<T>(_ action: () throws -> T) rethrows -> T {
        configurationLock.lock()
        defer { configurationLock.unlock() }
        return try action()
    }
}

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

/// Helper type for accessing the Backpack fonts bundle when using SwiftPM.
public enum BackpackFontsBundle {
  /// Returns the bundle that contains the Backpack font resources.
  public static var bundle: Bundle {
#if SWIFT_PACKAGE && SWIFT_MODULE_RESOURCE_BUNDLE_AVAILABLE
    return Bundle.module
#elseif canImport(ObjectiveC)
    return Bundle(for: BundleFinder.self)
#else
    // Fallback for non-ObjC platforms where Bundle(for:) is unavailable.
    return .main
#endif
  }

#if canImport(ObjectiveC)
  private final class BundleFinder {}
#endif
}

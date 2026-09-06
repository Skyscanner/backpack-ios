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
import UIKit

/// Loads an image from the snapshot tests' asset catalogue.
///
/// Under CocoaPods these images arrived in a nested `SnapshotTestImages.bundle`,
/// produced by the podspec's `resource_bundle`. SwiftPM instead processes
/// `Images.xcassets` straight into the test target's own bundle, so the images
/// are read from `Bundle.module`.
func testImage(named name: String) -> UIImage? {
    UIImage(named: name, in: .module, compatibleWith: nil)
}

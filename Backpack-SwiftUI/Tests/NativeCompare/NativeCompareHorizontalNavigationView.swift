//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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
@testable import Backpack_SwiftUI

/// Side by side: BPKHorizontalNavigation (left) against the stock segmented Picker with text tabs
/// (right), the stock one carrying Backpack semantic tokens only.
/// Layout and legend are shared: NativeCompareSupport.swift.
typealias NativeCompareHorizontalNavigationView = NativeCompareView<HorizontalNavigationComparison>

/// One comparison: header, the pair side by side, and the colour legend.
typealias NativeCompareHorizontalNavigationRow = NativeCompareRow<HorizontalNavigationComparison>

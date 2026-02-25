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

/// Defines the trailing content types for BPKCellItem.
/// Mutually exclusive - only one slot type can be active at a time.
public enum BPKCellItemSlot {
    /// Right-pointing chevron icon for navigation cells.
    case chevron
    /// Toggle switch control with a binding to track on/off state.
    case `switch`(isOn: Binding<Bool>)
    /// Secondary text value displayed on trailing edge.
    case text(String)
    /// Tappable link with text, URL, and action callback.
    case link(text: String, url: String, action: (String) -> Void)
    /// Trailing image for partner logos or branding.
    case image(Image)
}

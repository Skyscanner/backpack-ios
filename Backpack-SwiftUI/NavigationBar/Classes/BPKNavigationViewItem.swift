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

public struct BPKNavigationBarItem {
    let type: ButtonType
    let action: () -> Void
    
    public init(type: ButtonType, action: @escaping () -> Void) {
        self.type = type
        self.action = action
    }
    
    public enum ButtonType {
        case backButton(_ accessibiltyLabel: String, accessibilityIdentifier: String? = nil)
        case closeButton(_ accessibiltyLabel: String, accessibilityIdentifier: String? = nil)
        case icon(BPKIcon, _ accessibiltyLabel: String, accessibilityIdentifier: String? = nil)
        case title(String)
    }
}

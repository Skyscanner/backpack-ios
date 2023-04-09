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

public struct BPKDialogButton {
    let title: String
    let action: () -> Void
    let style: BPKButton.Style
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        style = .secondary
    }
    
    init(_ title: String, _ style: BPKButton.Style, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.style = style
    }
    
    init(button: BPKDialogButton, style: BPKButton.Style) {
        title = button.title
        action = button.action
        self.style = style
    }
}

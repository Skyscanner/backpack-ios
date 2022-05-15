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

extension BPKButton {
    public struct Icon {
        let icon: BPKIcon
        let position: IconPosition
        
        public init(icon: BPKIcon, position: IconPosition) {
            self.icon = icon
            self.position = position
        }
    }

    public enum IconPosition {
        /// The image positioned on the leading side of the label.
        case leading
        
        /// The image positioned on the trailing side of the label.
        case trailing
    }
}
//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

extension BPKSponsoredInsetBanner {
    public enum Variant {
        case onLight
        case onDark
        
        var color: BPKColor {
            self == .onDark ? BPKColor.textOnDarkColor : BPKColor.textOnLightColor
        }
        
        var buttonStyle: BPKButton.Style {
            self == .onDark ? .linkOnDark : .link
        }
    }
    
    public struct CallToAction {
        public let text: String
        public let accessibilityHint: String
        public let onClick: () -> Void
        
        public init(text: String, accessibilityHint: String) {
            self.text = text
            self.accessibilityHint = accessibilityHint
            self.onClick = {}
        }
    }
}

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

extension BPKBadge {
    @objcMembers
    @objc(BPKBadgeIcon)
    public class Icon: NSObject {
        public init(position: Position, iconName: BPKSmallIconName) {
            self.position = position
            self.iconName = iconName
        }
        
        let position: Position
        let iconName: BPKSmallIconName
    }
}

extension BPKBadge.Icon {
    
    @objc(BPKBadgeIconPosition)
    public enum Position: UInt {
        case leading, trailing
    }
}

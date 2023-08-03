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

extension BPKCardListLayout {
    public enum Accessory {
        case sectionHeaderButton(SectionHeaderAction)
        case expand(String, String, SectionHeaderAction? = nil)
        case footerButton(AccessoryAction)
        
        var sectionHeaderButton: SectionHeaderAction? {
            switch self {
            case .expand(_, _, let sectionHeaderAction):
                return sectionHeaderAction
            case .sectionHeaderButton(let sectionHeaderAction):
                return sectionHeaderAction
            default:
                return nil
            }
        }
    }
}

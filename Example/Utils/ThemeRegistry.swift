//
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
import Backpack.Theme

class ThemeRegistry: NSObject {

@objc
    class func register(theme: BPKThemeDefinition) {
        guard let themeContainerUIViewClass = theme.themeContainerClass as? UIAppearanceContainer.Type else {
            return
        }
        
        let selectableCellAppearance =
        BPKTableViewSelectableCell.appearance(whenContainedInInstancesOf: [themeContainerUIViewClass])
        selectableCellAppearance.selectedColor = theme.primaryColor
        
        let colorCellAppearance =
        ColorPreviewCollectionViewCell.appearance(whenContainedInInstancesOf: [themeContainerUIViewClass])
        colorCellAppearance.primaryColor = theme.primaryColor
        colorCellAppearance.skyGrayTint07 = theme.gray50
        colorCellAppearance.skyGrayTint06 = theme.gray100
        colorCellAppearance.skyGrayTint04 = theme.gray300
        colorCellAppearance.skyGrayTint02 = theme.gray500
        colorCellAppearance.skyGrayTint01 = theme.gray700
        colorCellAppearance.skyGray = theme.gray900
    }
    
}

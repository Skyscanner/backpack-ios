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

// Hold shared logic between BPKSaveCardButton & BPKShareCardButton
final class CardButtonViewConfigurator {

    // CardButton Required a larger hit area of at least 48px
    let widthHeight = BPKSpacingLg * 2

    func createContainedBackgroundCircle() -> UIView {
        let circle = UIView()
        circle.backgroundColor = BPKColor.textDisabledOnDarkColor
        circle.isUserInteractionEnabled = false
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }

    func shouldAddButtonBackground(style: BPKCardButtonStyle) -> Bool {
        switch style {
        case .contained:
            return true
        case .default, .onDark:
            return false
        }
    }

    func buttonBackgroundSize(size: BPKCardButtonSize) -> CGFloat {
        switch size {
        case .default:
            return BPKIcon.concreteSizeForLargeIcon.width + BPKSpacingBase
        case .small:
            return BPKIcon.concreteSizeForSmallIcon.width + BPKSpacingBase
        }
    }
}

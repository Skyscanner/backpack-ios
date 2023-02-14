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

public enum BPKCardButtonSize {
    case `default`
    case small

    var backgroundCircleSize: CGFloat {
        switch self {
        case .default:
            return BPKIcon.concreteSizeForLargeIcon.width + BPKSpacingBase
        case .small:
            return BPKIcon.concreteSizeForSmallIcon.width + BPKSpacingBase
        }
    }

    // CardButton Required a larger hit area of at least 48px
    var buttonWidthHeight: CGFloat { BPKSpacingLg * 2 }
}

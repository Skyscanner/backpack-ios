/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

import Backpack_Common

public enum BPKCardElevation {
    case `default`, focus, none

    func shadow(for style: BPKCardStyle, config: BpkConfiguration?) -> BPKShadow? {
        // When config.CardConfig is enabled, turn off all elevation
        if config?.cardConfig != nil {
            return nil
        }

        switch self {
        case .none: return nil
        case .focus: return .lg
        case .`default`: return .sm
        }
    }

    func backgroundColor(for style: BPKCardStyle, config: BpkConfiguration?) -> BPKColor {
        // When config.CardConfig is enabled and onDefault style, use canvasContrast
        if config?.cardConfig != nil && style == .onDefault {
            return .surfaceLowContrastColor
        }

        switch style {
        case .onDefault:
            return self == .focus ? .surfaceElevatedColor : .surfaceDefaultColor
        case .onContrast:
            return self == .focus ? .surfaceElevatedColor : .surfaceDefaultColor
        }
    }
}

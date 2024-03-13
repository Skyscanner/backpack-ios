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

public enum BPKNavigationBarStyle {
    case `default`(_ displayMode: NavigationBarItem.TitleDisplayMode = .automatic)
    case transparent(_ displayMode: NavigationBarItem.TitleDisplayMode = .automatic)
    case surfaceContrast
    
    var expandedByDefault: Bool {
        displayMode != .inline
    }

    var foregroundColor: BPKColor {
        switch self {
        case .default: return .textPrimaryColor
        case .transparent: return .textOnDarkColor
        case .surfaceContrast: return .textOnDarkColor
        }
    }
    
    var safeAreasToIgnore: Edge.Set {
        switch self {
        case .transparent: return .top
        default: return []
        }
    }
    
    var backgroundColor: BPKColor {
        switch self {
        case .default: return .canvasColor
        case .transparent: return .clear
        case .surfaceContrast: return .surfaceContrastColor
        }
    }
    
    var lineColor: BPKColor? {
        switch self {
        case .default: return .lineColor
        case .transparent: return nil
        case .surfaceContrast: return .lineOnDarkColor
        }
    }
    
    var displayMode: NavigationBarItem.TitleDisplayMode {
        switch self {
        case .default(let displayMode): return displayMode
        case .transparent(let displayMode): return displayMode
        case .surfaceContrast: return .inline
        }
    }
}

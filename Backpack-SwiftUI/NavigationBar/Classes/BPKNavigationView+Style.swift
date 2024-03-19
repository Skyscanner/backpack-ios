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
    case `default`
    case transparent
    case surfaceContrast
    
    func foregroundColor(expanded: Bool) -> BPKColor {
        switch self {
        case .default: return .textPrimaryColor
        case .transparent: return expanded ? .textOnDarkColor : .textPrimaryColor
        case .surfaceContrast: return .textOnDarkColor
        }
    }
    
    var navigationBarHeight: CGFloat {
        collapsedHeight + expandedNavigationBarHeight
    }
    
    var collapsedHeight: CGFloat {
        44
    }
    
    var expandedNavigationBarHeight: CGFloat {
        switch self {
        case .default, .transparent: return 52
        case .surfaceContrast: return 0
        }
    }
    
    var bottomSafeAreaInsetHeight: CGFloat {
        switch self {
        case .default, .surfaceContrast: return expandedNavigationBarHeight
        case .transparent: return 0
        }
    }
    
    var verticalOffset: CGFloat {
        switch self {
        case .transparent: return 0
        default: return navigationBarHeight
        }
    }
    
    var largeTitlePadding: CGFloat {
        BPKSpacing.md.value
    }
    
    var safeAreasToIgnore: Edge.Set {
        switch self {
        case .transparent: return .top
        default: return []
        }
    }
    
    func backgroundColor(expanded: Bool) -> BPKColor {
        switch self {
        case .default: return .canvasColor
        case .transparent: return expanded ? .clear : .canvasColor
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
    
    var supportsLargeTitle: Bool {
        switch self {
        case .default: return true
        case .transparent: return true
        case .surfaceContrast: return false
        }
    }
}

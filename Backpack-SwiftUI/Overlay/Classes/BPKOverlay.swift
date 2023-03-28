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

import SwiftUI

public enum BPKOverlayType {
    
    /// A solid overlay.
    ///
    /// Applies a solid color overlay across the view with a specified level of strength.
    /// - Parameter level: The strength of the overlay.
    case solid(_ level: Level)
    
    /// A linear gradient.
    ///
    /// The gradient applies the color function as a linear interpolation
    /// in the direction specified across the view, with a specified level of strength.
    /// - Parameters:
    ///   - level: The strength of the overlay.
    ///   - direction: The direction of the gradient.
    case linear(_ level: Level, _ direction: LinearOverlayDirection)
    
    /// A vignette overlay.
    ///
    /// Applies a vignette overlay across the view.
    case vignette
    
    public enum Level {
        case off, low, medium, high
        
        var opacity: Double {
            switch self {
            case .off: return 0
            case .low: return 0.15
            case .medium: return 0.3
            case .high: return 0.45
            }
        }
    }
    
    var opacity: Double {
        switch self {
        case .solid(let level):
            return level == .high ? 0.4 : level.opacity
        case .linear(let level, _):
            return level.opacity
        case .vignette:
            return 0.12
        }
    }
}

/// The Direction that a Linear Overlay can be configured with.
public enum LinearOverlayDirection {
    case top
    case bottom
    case leading
    case trailing
    
    var startPoint: UnitPoint {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        case .leading: return .leading
        case .trailing: return .trailing
        }
    }
    
    var endPoint: UnitPoint {
        switch self {
        case .top: return .bottom
        case .bottom: return .top
        case .leading: return .trailing
        case .trailing: return .leading
        }
    }
}

struct BPKOverlay_Previews: PreviewProvider {
    static var previews: some View {
        Color.white
            .frame(width: 110, height: 110)
            .bpkOverlay(.linear(.high, .leading))
            .cornerRadius(BPKCornerRadius.lg.value)
    }
}

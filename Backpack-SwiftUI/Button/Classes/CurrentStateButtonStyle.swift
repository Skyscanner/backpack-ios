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

struct CurrentStateButtonStyle: ButtonStyle {
    let style: BPKButton.Style
    let size: BPKButton.Size
    let iconOnly: Bool
    let getCurrentState: (_ isPressed: Bool) -> BPKButton.CurrentState
    let colorProvider: ButtonColorProvider
    
    private var height: CGFloat {
        size == .default ? 36 : 48
    }
    
    private var width: CGFloat? {
        iconOnly ? height : nil
    }
    
    private var sidesPadding: BPKSpacing {
        let hasPadding = iconOnly || style == .link || style == .linkOnDark
        return hasPadding ? .none : .base
    }
    
    private func colors(forConfiguration configuration: Configuration) -> BPKButtonColors {
        let currentState = getCurrentState(configuration.isPressed)
        return colorProvider.color(forStyle: style, currentState: currentState)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let background = colors(forConfiguration: configuration).background
        let foreground = colors(forConfiguration: configuration).foreground
        
        configuration.label
            .frame(width: width, height: height)
            .padding([.leading, .trailing], sidesPadding)
            .background(background)
            .foregroundColor(foreground)
            .clipShape(RoundedRectangle(cornerRadius: .sm))
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

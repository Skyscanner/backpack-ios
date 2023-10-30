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

struct InsetBannerButtonStyle: ButtonStyle {
    let foregroundColor: Color
    let backgroundColor: Color
    typealias ButtonColors = (foreground: Color, background: Color)
    
    private func colors(forConfiguration configuration: Configuration) -> ButtonColors {
        if configuration.isPressed {
            let darkerBackground = Color.black.opacity(0.1)
            return(foregroundColor, darkerBackground)
        } else {
            return(foregroundColor, backgroundColor)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let (foreground, background) = colors(forConfiguration: configuration)
        configuration.label
            .background(background)
            .foregroundColor(foreground)
            .clipShape(RoundedRectangle(cornerRadius: .sm))
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

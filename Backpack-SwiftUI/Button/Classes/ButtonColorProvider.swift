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

protocol ButtonColorProvider {
    func color(forStyle style: BPKButton.Style, currentState: BPKButton.CurrentState) -> BPKButton.ColorSets.Colors
}

struct DefaultButtonColorProvider: ButtonColorProvider {
    func color(forStyle style: BPKButton.Style, currentState: BPKButton.CurrentState) -> BPKButton.ColorSets.Colors {
        let colorSet = colorSet(forStyle: style)
        switch currentState {
        case .regular: return colorSet.regular
        case .loading: return colorSet.loading
        case .highlighted: return colorSet.highlighted
        case .disabled: return colorSet.disabled
        }
    }
    
    private func colorSet(forStyle style: BPKButton.Style) -> BPKButton.ColorSets {
        switch style {
        case .primary: return .primary
        case .secondary: return .secondary
        case .secondaryOnDark: return .secondaryOnDark
        case .destructive: return .destructive
        case .featured: return .featured
        case .link: return .link
        case .linkOnDark: return .linkOnDark
        case .primaryOnDark: return .primaryOnDark
        case .primaryOnLight: return .primaryOnLight
        }
    }
}

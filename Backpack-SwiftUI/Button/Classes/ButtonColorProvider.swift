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

struct ButtonColorProvider {
    let colorSetFactory: ButtonColorSetFactory
    
    func color(forStyle style: BPKButton.Style, currentState: BPKButton.CurrentState) -> BPKButtonColors {
        let colorSet = colorSetFactory.colorSet(forStyle: style)
        switch currentState {
        case .regular: return colorSet.regular
        case .loading: return colorSet.loading
        case .highlighted: return colorSet.highlighted
        case .disabled: return colorSet.disabled
        }
    }
}
protocol ButtonColorSetFactory {
    func colorSet(forStyle style: BPKButton.Style) -> BPKButtonColorSet
}

struct DefaultButtonColorSetFactory: ButtonColorSetFactory {
    func colorSet(forStyle style: BPKButton.Style) -> BPKButtonColorSet {
        switch style {
        case .primary: return PrimaryBPKButtonColorSet()
        case .secondary: return SecondaryBPKButtonColorSet()
        case .secondaryOnDark: return SecondaryOnDarkBPKButtonColorSet()
        case .destructive: return DestructiveBPKButtonColorSet()
        case .featured: return FeaturedBPKButtonColorSet()
        case .link: return LinkBPKButtonColorSet()
        case .linkOnDark: return LinkOnDarkBPKButtonColorSet()
        case .primaryOnDark: return PrimaryOnDarkBPKButtonColorSet()
        case .primaryOnLight: return PrimaryOnLightBPKButtonColorSet()
        }
    }
}

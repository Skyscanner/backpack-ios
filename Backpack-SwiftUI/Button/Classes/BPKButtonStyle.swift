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

extension BPKButton {
    public enum Style {
        /// Primary button style, suitable for use as the primary call to action
        case primary
        
        /// Secondary button style, suitable for secondary call to actions.
        case secondary
        
        /// Should typically be paired with a confirmation.
        case destructive
        
        /// the primary style.
        case featured
        
        /// Link button style, suitable for inline display and de-emphasized actions.
        case link
        
        /// Primary on Dark button style, suitable for use on dark coloured backgrounds.
        case primaryOnDark
        
        /// Primary on Light button style, suitable for use on light coloured backgrounds.
        case primaryOnLight
        
        /// Secondary on Dark button style, suitable for use on dark coloured backgrounds.
        case secondaryOnDark
        
        /// Link on Dark button style, suitable for use on dark coloured backgrounds.
        case linkOnDark
    }
}

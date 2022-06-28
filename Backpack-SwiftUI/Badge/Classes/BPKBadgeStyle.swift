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

extension BPKBadge {
    public enum Style {
        /// The default style, will change in dark mode
        case `default`
        
        /// The epmahsized style, will change in dark mode
        case emphasis
        
        /// The success style, using a green background
        case success
        
        /// The warning style, using a yellow background
        case warning
        
        /// The error style, using a red background
        case error
        
        /// The onDark style, using a white background
        case onDark
        
        /// The outline style, using a clear background with white outline
        case outline
    }
}

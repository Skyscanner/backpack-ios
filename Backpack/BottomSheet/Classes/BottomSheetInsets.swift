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

public struct BottomSheetInsets {
    public let full: CGFloat?
    public let half: CGFloat?
    public let tip: CGFloat?
    
    /// Default insets for the bottom sheet.
    public init() {
        self.init(full: nil, half: 386.0, tip: 120.0)
    }
    
    /// Use this initializer to have full control over the heights and spacing of your bottom sheet
    /// - Parameters:
    ///   - full: A top inset from the safe area
    ///   - half: A bottom inset from the safe area
    ///   - tip:  A bottom inset from the safe area
    public init(full: CGFloat?, half: CGFloat?, tip: CGFloat?) {
        self.full = full
        self.half = half
        self.tip = tip
    }
}

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

public struct BPKPageIndicator: View {
    public enum Variant {
        case `default`, overImage
    }
    
    //    Switches between default and overImage style
    public let variant: Variant
    
    //    This sets the current highlighted indicator
    @State public var currentIndex: Int
    
    //    This is the total number of indicators to be available
    @State public var totalIndicators: Int
    
    //    This is a label for screen readers on the indicators themselves
    @State public var indicatorLabel: String
    
    public init(variant: Variant, currentIndex: Int, totalIndicators: Int, indicatorLabel: String) {
        self.variant = variant
        self.currentIndex = currentIndex
        self.totalIndicators = totalIndicators
        self.indicatorLabel = indicatorLabel
    }
    
    public var body: some View {
        PageControl(
            variant: variant,
            currentIndex: $currentIndex,
            totalIndicators: $totalIndicators,
            indicatorLabel: $indicatorLabel
        )
    }
}

struct BPKPageIndicator_Previews: PreviewProvider {
    static var previews: some View {
        BPKPageIndicator(
            variant: .default,
            currentIndex: 0,
            totalIndicators: 3,
            indicatorLabel: ""
        )
    }
}

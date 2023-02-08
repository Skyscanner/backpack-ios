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

public struct BPKPageIndicator: UIViewRepresentable {
    public enum Variant {
        case `default`, overImage
    }
    
    public let variant: Variant
    @Binding public var currentIndex: Int
    @Binding public var totalIndicators: Int
    
    public init(
        variant: Variant = .default,
        currentIndex: Binding<Int>,
        totalIndicators: Binding<Int>
    ) {
        self.variant = variant
        _currentIndex = currentIndex
        _totalIndicators = totalIndicators
    }
    
    public func makeUIView(context: Context) -> UIPageControl {
        UIPageControl()
    }
    
    public func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.isUserInteractionEnabled = false
        uiView.numberOfPages = totalIndicators
        uiView.currentPage = currentIndex
        
        switch variant {
        case .`default`:
            uiView.currentPageIndicatorTintColor = BPKColor.textSecondaryColor.value
            uiView.pageIndicatorTintColor = BPKColor.lineColor.value
        case .overImage:
            uiView.currentPageIndicatorTintColor = BPKColor.textOnDarkColor.value
            uiView.pageIndicatorTintColor = BPKColor.lineOnDarkColor.value
        }
    }
}


struct BPKPageIndicator_Previews: PreviewProvider {
    static var previews: some View {
        BPKPageIndicator(currentIndex: .constant(0), totalIndicators: .constant(3))
    }
}

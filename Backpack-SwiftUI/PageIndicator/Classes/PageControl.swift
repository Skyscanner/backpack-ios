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

//  This wraps a UIPageControl so that it can be exposed to SwiftUI and is used in BPKPageIndicator
struct PageControl: UIViewRepresentable {
    let variant: BPKPageIndicator.Variant
    @Binding var currentIndex: Int
    @Binding var totalIndicators: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        UIPageControl()
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
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

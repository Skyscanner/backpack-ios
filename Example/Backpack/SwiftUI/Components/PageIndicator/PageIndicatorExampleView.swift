//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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
import Backpack_SwiftUI

struct PageIndicatorExampleView: View {
    @State var currentIndex: Int = 0
    @State var totalIndicators: Int = 3
    
    var body: some View {
        VStack(spacing: BPKSpacingBase) {
            BPKPageIndicator(
                variant: .default,
                currentIndex: $currentIndex,
                totalIndicators: $totalIndicators
            )
            
            ZStack(alignment: .bottom) {
                Image("dialog_image", label: Text(""))
                
                BPKPageIndicator(
                    variant: .overImage,
                    currentIndex: $currentIndex,
                    totalIndicators: $totalIndicators
                )
                .padding(BPKSpacingBase)
            }
        }
    }
}

struct PageIndicatorExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PageIndicatorExampleView()
    }
}

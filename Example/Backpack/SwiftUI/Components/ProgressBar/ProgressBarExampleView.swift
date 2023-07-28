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

struct ProgressBarExampleView: View {
    @State var progress: Float = 1.5
    
    var body: some View {
        VStack(alignment: .leading) {
            BPKText("Small", style: .heading3)
            BPKProgressBar(max: 3, stepped: false, size: .small, value: progress)
            BPKText("Steped", style: .heading5)
            BPKProgressBar(max: 3, stepped: true, size: .small, value: progress)
            BPKText("Large", style: .heading3)
            BPKProgressBar(max: 3, stepped: false, size: .large, value: progress)
            BPKText("Steped", style: .heading5)
            BPKProgressBar(max: 3, stepped: true, size: .large, value: progress)
            Spacer()
            BPKSlider(value: $progress, sliderBounds: 0...3, step: 0.2)
                .padding()
        }
        .padding()
    }
}

struct ProgressBarExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarExampleView()
    }
}

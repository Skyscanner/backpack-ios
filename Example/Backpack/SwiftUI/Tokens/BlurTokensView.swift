//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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

import CoreImage
import SwiftUI
import Backpack
import Backpack_SwiftUI

// swiftlint:disable indentation_width closure_body_length

struct BlurTokensView: View {
    
    @State var progressiveRadius = 24.0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Text("No Blurs")
                HStack(spacing: 8) {
                    Image("dialog_image")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(BPKCornerRadiusMd)
                    
                    Image("chessboard")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(BPKCornerRadiusMd)
                }
                Text("Uniform")
                HStack(spacing: 8) {
                    Image("dialog_image")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .blur(BPKBlur(radius: 4))
                        .cornerRadius(BPKCornerRadiusMd)
                    
                    Image("chessboard")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .blur(BPKBlur(radius: 4))
                        .cornerRadius(BPKCornerRadiusMd)
                }
                Text("Progressive")
                HStack(spacing: 8) {
                    BPKProgessiveBlurView(imageName: "dialog_image",
                                          blurRadius: Float(progressiveRadius), width: 150, height: 150)
                    .cornerRadius(BPKCornerRadiusMd)
                    BPKProgessiveBlurView(imageName: "chessboard",
                                          blurRadius: Float(progressiveRadius), width: 150, height: 150)
                    .cornerRadius(BPKCornerRadiusMd)
                }
                HStack {
                    Slider(value: $progressiveRadius, in: 0...50)
                    Text("Value: \(progressiveRadius, specifier: "%.2f")")
                }
                
                BPKProgessiveBlurView(imageName: "dialog_image",
                                      blurRadius: Float(progressiveRadius), width: 300, height: 300)

            }
            .padding()
        }
    }
}

struct BlurTokensView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BlurTokensView()
                .previewLayout(.sizeThatFits)
        }
    }
}

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
import Metal
import MetalKit

// swiftlint:disable closure_body_length
struct BlurTokensView: View {
    
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
                        .blur(BPKBlur())
                        .cornerRadius(BPKCornerRadiusMd)
                    
                    Image("chessboard")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .blur(BPKBlur())
                        .cornerRadius(BPKCornerRadiusMd)
                }
                Text("Progressive")
                HStack(spacing: 8) {
                    BPKProgessiveBlurView(imageName: "dialog_image", width: 150, height: 150)
                    BPKProgessiveBlurView(imageName: "chessboard", width: 150, height: 150)
                }
                
                BPKProgessiveBlurView(imageName: "dialog_image", width: 300, height: 300)
                .cornerRadius(BPKCornerRadiusMd)
                
                if #available(iOS 17, *) {
                    Image("chessboard")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .gradientBlur(radius: 20)
                } else {
                    Text("VERSION TOO OLD!")
                }

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

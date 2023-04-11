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

struct FlareExampleView: View {
    // swiftlint:disable closure_body_length
    var body: some View {
        VStack {
            HStack {
                BPKText("Medium", style: .heading4)
                Spacer()
                BPKFlareView {
                    flareContent
                        .padding(.bottom)
                        .background(.coreAccentColor)
                }
            }
            HStack {
                BPKText("Rect Corners", style: .heading4)
                Spacer()
                BPKFlareView(roundedCorners: false) {
                    flareContent
                        .padding(.bottom)
                        .background(.coreAccentColor)
                }
            }
            HStack {
                BPKText("Direction: Top", style: .heading4)
                Spacer()
                BPKFlareView(direction: .top) {
                    flareContent
                        .padding(.top)
                        .background(.coreAccentColor)
                }
            }
            HStack {
                BPKText("Small", style: .heading4)
                Spacer()
                BPKFlareView(size: .small) {
                    flareContent
                        .padding(.bottom, .md)
                        .background(.coreAccentColor)
                }
            }
        }
        .padding()
    }
    
    private var flareContent: some View {
        VStack {
            BPKText("Flare View!")
                .foregroundColor(.textPrimaryInverseColor)
        }
        .padding()
    }
}

struct FlareExampleView_Previews: PreviewProvider {
    static var previews: some View {
        FlareExampleView()
    }
}

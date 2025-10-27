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

import SwiftUI
import Backpack_SwiftUI
import Backpack_Common

struct ConfigurationTypographyView: View {

    var body: some View {
        VStack(spacing: .xl) {
            newTypographyStyles
            
            changeTypographyStyles
            
            Spacer()
        }
        .background(.gray)
        .onDisappear {
            BpkConfiguration.shared.reset()
        }
    }
    
    var newTypographyStyles: some View {
        VStack(spacing: 4) {
            BPKText("Editorial 4", style: .editorial4)
                .foregroundColor(.black)
            BPKText("Editorial 5", style: .editorial5)
                .foregroundColor(.black)
            BPKText("Editorial 6", style: .editorial6)
                .foregroundColor(.black)
            BPKText("Display 7", style: .display7)
                .foregroundColor(.black)
        }
    }
    
    var changeTypographyStyles: some View {
        VStack(spacing: 4) {
            BPKText("Heading 1 changes", style: .heading1)
                .foregroundColor(.black)
            BPKText("Heading 2 changes", style: .heading2)
                .foregroundColor(.black)
            BPKText("Heading 3 changes", style: .heading3)
                .foregroundColor(.black)
            BPKText("Heading 4 changes", style: .heading4)
                .foregroundColor(.black)
            BPKText("Heading 5 changes", style: .heading5)
                .foregroundColor(.black)
            BPKText("Hero 5 changes", style: .hero5)
                .foregroundColor(.black)
            BPKText("Hero 6 changes", style: .hero6)
                .foregroundColor(.black)
        }
    }
}

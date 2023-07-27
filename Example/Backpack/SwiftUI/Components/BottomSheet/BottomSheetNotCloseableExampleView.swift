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

struct BottomSheetNotCloseableExampleView: View {
    @State private var showBottomSheet = false
    
    var contentMode: BPKBottomSheetContentMode
    
    init(contentMode: BPKBottomSheetContentMode) {
        self.contentMode = contentMode
    }
    
    var content: some View {
        List(0..<20) {
            BPKText("\($0) row item")
        }
    }
    
    var body: some View {
        GeometryReader { _ in
            BPKButton("Show bottom sheet") {
                showBottomSheet.toggle()
            }
            .bpkBottomSheet(
                isPresented: $showBottomSheet,
                contentMode: contentMode,
                title: "Some Title",
                bottomSheetContent: {
                    content
                }
            )
        }
    }
}

struct BottomSheetFullSizeExampleView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetNotCloseableExampleView(contentMode: .large)
    }
}

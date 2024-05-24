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

struct ImageGalleryPreviewExampleView: View {
    @State var currentIndex: Int = 0
    
    var body: some View {
        BPKImageGalleryPreview(
            images: (1...4).map(image(_:)),
            currentIndex: $currentIndex,
            onImageClicked: { print("\($0)") }
        )
        .frame(height: 350)
        .onChange(of: currentIndex) { newValue in
            print("Selected index: \(newValue)")
        }
    }
    
    private func image(_ number: Int) -> some View {
        Image("carousel_placeholder_\(number)")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

struct ImageGalleryPreviewExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryPreviewExampleView()
    }
}

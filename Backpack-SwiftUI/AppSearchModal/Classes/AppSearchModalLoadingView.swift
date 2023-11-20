/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2023 Skyscanner Ltd
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

struct AppSearchModalLoadingView: View {
    let state: BPKAppSearchModalLoading
    private let skeletonCount: Int = 10
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                VStack(alignment: .leading) {
                    ForEach((0..<skeletonCount), id: \.self) { _ in
                        BPKSkeleton.bodytext()
                            .shimmering()
                            .padding(.vertical, .base)
                    }
                }
                Spacer()
            }
        }
        .accessibilityLabel(state.accessibilityLabel)
    }
}

struct AppSearchModalLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        AppSearchModalLoadingView(
            state: .init(accessibilityLabel: "Close")
        )
    }
}

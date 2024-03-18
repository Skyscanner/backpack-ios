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

struct ExpandedNavigationBar: View {
    let title: String?
    let style: BPKNavigationBarStyle
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color(style.backgroundColor(expanded: true))
                .frame(height: style.expandedNavigationBarHeight)
            BPKText(title ?? "", style: .heading2)
                .foregroundColor(style.foregroundColor(expanded: true))
                .padding(.top, -style.largeTitlePadding)
                .frame(height: style.expandedNavigationBarHeight)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, .base)
        }
    }
}

struct ExpandedNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExpandedNavigationBar(
                title: "Hotels",
                style: .default
            )
            ExpandedNavigationBar(
                title: "Hotels",
                style: .transparent
            )
        }
        .frame(maxHeight: .infinity)
        .background(.red)
    }
}

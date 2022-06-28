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

struct BPKBadge: View {
    private let title: String
    private let icon: BPKIcon?
    private var style: BPKBadge.Style = .success
    
    public init(_ title: String, icon: BPKIcon? = nil) {
        self.title = title
        self.icon = icon
    }
    
    var body: some View {
        Text("Hello, World!")
            .padding([.leading, .trailing], .sm)
            .padding([.top, .bottom], .md)
            .background(.panjin)
    }
    
    public func badgeStyle(_ style: BPKBadge.Style) -> BPKBadge {
        var result = self
        result.style = style
        return result
    }
}

struct BPKBadge_Previews: PreviewProvider {
    static var previews: some View {
        BPKBadge("Success", icon: .return)
    }
}

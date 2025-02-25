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

public struct BPKPointerMapMarker: View {
    public init() {}
    
    public var body: some View {
        Circle()
            .stroke(Color(.textOnDarkColor), lineWidth: 2)
            .background(
                Circle()
                    .foregroundColor(.corePrimaryColor)
            )
            .frame(width: 12, height: 12)
    }
}

struct BPKPointerMapMarker_Previews: PreviewProvider {
    static var previews: some View {
        BPKPointerMapMarker()
    }
}

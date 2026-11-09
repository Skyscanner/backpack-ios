//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

struct IconBulletExampleView: View {
    
    let styles: [BPKIconBullet.Style] = [.loyalty, .strong, .brand]
    let sizes: [BPKIconBullet.Size] = [.small, .medium, .large]
    var body: some View {
        VStack(spacing: 16) {
            ForEach(sizes, id: \.self) { size in
                HStack(spacing: 8) {
                    ForEach(self.styles, id: \.self) { style in
                        BPKIconBullet(.trendDown)
                            .iconBulletStyle(style)
                            .iconBulletSize(size)
                    }
                }
            }
        }
    }
}

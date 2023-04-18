/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

struct SliderThumbView: View {
    let size: CGFloat
    let offset: CGFloat
    let onDrag: (DragGesture.Value) -> Void
    
    var body: some View {
        Circle()
            .fill(Color(.coreAccentColor))
            .frame(width: size, height: size)
            .shadow(.sm)
            .offset(x: offset)
            .highPriorityGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        onDrag(value)
                    }
            )
    }
}

struct SliderThumbView_Previews: PreviewProvider {
    static var previews: some View {
        SliderThumbView(size: 20, offset: 0) { _ in }
    }
}

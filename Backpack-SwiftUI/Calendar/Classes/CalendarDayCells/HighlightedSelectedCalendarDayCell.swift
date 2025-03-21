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

struct HighlightedSelectedCalendarDayCell: View {
    let calendar: Calendar
    let date: Date
    
    var body: some View {
        ZStack {
            Circle().fill(Color(.coreAccentColor))
                .frame(width: 30, height: 30)
            Circle().stroke(Color(.coreAccentColor), lineWidth: 1)
                .frame(width: 36, height: 36)
            BPKText("\(calendar.component(.day, from: date))", style: .label1)
                .foregroundColor(.textPrimaryInverseColor)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .padding(.vertical, .md)
        }
//        GeometryReader { geometry in
//            let size = min(geometry.size.width, geometry.size.height)
//            ZStack {
//                BPKText("\(calendar.component(.day, from: date))", style: .label1)
//                    .foregroundColor(.textPrimaryInverseColor)
//                    .lineLimit(1)
//                    .frame(width: size, height: size)
//                    .padding(.vertical, .md)
//                Circle().fill(Color(.coreAccentColor))
//                    .frame(width: size * 0.8, height: size * 0.8)
//                Circle().stroke(Color(.coreAccentColor), lineWidth: 1)
//                    .frame(width: size, height: size)
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height)
//        }
    }
}

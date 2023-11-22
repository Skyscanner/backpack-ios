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

struct LowerAndUpperBoundSelectedCell: View {
    let calendar: Calendar
    let date: Date
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ZStack {
                    Circle()
                        .strokeBorder(Color(.coreAccentColor), lineWidth: 1)
                    Circle()
                        .frame(width: proxy.size.height - 6)
                        .foregroundColor(.coreAccentColor)
                        
                }
            }
            BPKText("\(calendar.component(.day, from: date))", style: .label1)
                .foregroundColor(.textPrimaryInverseColor)
                .lineLimit(1)
                .padding(.md)
        }
    }
}

struct LowerAndUpperBoundSelectedCell_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let date = calendar.date(from: .init(year: 2023, month: 11, day: 8))!
     
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 1), spacing: 0) {
            LowerAndUpperBoundSelectedCell(calendar: calendar, date: date)
        }
    }
}

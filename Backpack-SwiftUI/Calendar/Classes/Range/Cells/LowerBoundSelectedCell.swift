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

struct LowerBoundSelectedCell: View {
    let calendar: Calendar
    let date: Date
    let highlighted: Bool

    init(calendar: Calendar, date: Date, highlighted: Bool = true) {
        self.calendar = calendar
        self.date = date
        self.highlighted = highlighted
    }

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Color(.surfaceSubtleColor)
                    .frame(width: proxy.size.width / 2)
                    .offset(x: proxy.size.width / 2)
            }
            BPKText("\(calendar.component(.day, from: date))", style: .label1)
                .foregroundColor(textColor)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .padding(.vertical, .md)
                .background(circleColor)
                .clipShape(Circle())
        }
    }

    private var circleColor: BPKColor {
        highlighted ? .coreAccentColor : .surfaceSubtleColor
    }

    private var textColor: BPKColor {
        highlighted ? .textPrimaryInverseColor : .black
    }
}

struct LowerBoundSelectedCell_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let date = calendar.date(from: .init(year: 2023, month: 11, day: 8))!
        
        LowerBoundSelectedCell(calendar: calendar, date: date)
    }
}

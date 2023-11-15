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

struct CalendarHeader: View {
    let calendar: Calendar
    
    var body: some View {
        VStack(spacing: BPKSpacing.none) {
            HStack {
                ForEach(0..<7) { index in
                    BPKText("\(weekdays[index])", style: .label2)
                        .foregroundColor(.textSecondaryColor)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, BPKSpacing.md.value + BPKSpacing.sm.value)
                }
            }
            Divider()
        }
        .accessibilityHidden(true)
    }
    
    private var weekdays: [String] {
        var weekdaySymbols = calendar.veryShortStandaloneWeekdaySymbols
        // We treat Sunday as the last day of the week, so we rotate the symbols array to match.
        weekdaySymbols.append(weekdaySymbols.remove(at: weekdaySymbols.startIndex))
        return weekdaySymbols
    }
}

struct CalendarHeader_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHeader(calendar: Calendar.current)
    }
}

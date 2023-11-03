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

struct RangeSelectionCalendarDayCell: View {
    let date: Date
    @Binding var selection: ClosedRange<Date>?
    let calendar: Calendar
    
    var body: some View {
        if let selection, selection.contains(date) {
            if date == selection.lowerBound {
                LowerBoundSelectedCell(calendar: calendar, date: date)
            } else if date == selection.upperBound {
                UpperBoundSelectedCell(calendar: calendar, date: date)
            } else {
                InbetweenSelectionCell(calendar: calendar, date: date)
            }
        } else {
            DefaultSelectionCell(calendar: calendar, date: date)
        }
    }
}

struct CalendarSelectableCell<Cell: View>: View {
    @ViewBuilder let cell: Cell
    let onSelection: () -> Void
    
    var body: some View {
        cell.onTapGesture(perform: onSelection)
    }
}

struct DisabledSelectionCell: View {
    let calendar: Calendar
    let date: Date
    
    var body: some View {
        BPKText("\(calendar.component(.day, from: date))", style: .label1)
            .lineLimit(1)
            .foregroundColor(.textDisabledColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, .md)
    }
}

struct DefaultSelectionCell: View {
    let calendar: Calendar
    let date: Date
    
    var body: some View {
        BPKText("\(calendar.component(.day, from: date))", style: .label1)
            .lineLimit(1)
            .padding(.vertical, .md)
    }
}

struct InbetweenSelectionCell: View {
    let calendar: Calendar
    let date: Date
    
    var body: some View {
        BPKText("\(calendar.component(.day, from: date))", style: .label1)
            .lineLimit(1)
            .padding(.vertical, .md)
            .frame(maxWidth: .infinity)
            .background(.surfaceSubtleColor)
    }
}

struct LowerBoundSelectedCell: View {
    let calendar: Calendar
    let date: Date
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Color(.surfaceSubtleColor)
                    .frame(width: proxy.size.width / 2)
                    .offset(x: proxy.size.width / 2)
            }
            BPKText("\(calendar.component(.day, from: date))", style: .label1)
                .foregroundColor(.textPrimaryInverseColor)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .padding(.vertical, .md)
                .background(.coreAccentColor)
                .clipShape(Circle())
        }
    }
}

struct SingleSelectedCell: View {
    let calendar: Calendar
    let date: Date
    
    var body: some View {
        BPKText("\(calendar.component(.day, from: date))", style: .label1)
            .foregroundColor(.textPrimaryInverseColor)
            .lineLimit(1)
            .frame(maxWidth: .infinity)
            .padding(.vertical, .md)
            .background(.coreAccentColor)
            .clipShape(Circle())
    }
}

struct UpperBoundSelectedCell: View {
    let calendar: Calendar
    let date: Date
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Color(.surfaceSubtleColor)
                    .frame(width: proxy.size.width / 2)
            }
            BPKText("\(calendar.component(.day, from: date))", style: .label1)
                .foregroundColor(.textPrimaryInverseColor)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .padding(.vertical, .md)
                .background(.coreAccentColor)
                .clipShape(Circle())
        }
    }
}

struct SelectedCalendarDayCell_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let date = calendar.date(from: .init(year: 2023, month: 11, day: 15))!
        
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 6), spacing: 0) {
            DefaultSelectionCell(calendar: calendar, date: date)
            DisabledSelectionCell(calendar: calendar, date: date)
            LowerBoundSelectedCell(calendar: calendar, date: date)
            InbetweenSelectionCell(calendar: calendar, date: date)
            UpperBoundSelectedCell(calendar: calendar, date: date)
            SingleSelectedCell(calendar: calendar, date: date)
        }
    }
}

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
@objc
@objcMembers
public class BPKCalendarWholeMonthConfiguration: NSObject {
    public let title: String
    private let selectableMonthRange: ClosedRange<BPKYearMonth>?
    
    public init(title: String, selectableMonthRange: ClosedRange<BPKYearMonth>? = nil) {
        self.title = title
        self.selectableMonthRange = selectableMonthRange
    }
    
    /**
     * Check if the passed month is included in the selectable months
     *
     * @param month The mont to check
     * @return True when the month is in the selectable range, or when the selectable ragne is nil
     */
    public func isWholeMonthSelectionEnabled(month: BPKSimpleDate) -> Bool {
        guard let selectableMonthRange else {
            return true
        }
        
        let currentMonth = BPKYearMonth(year: month.year, month: month.month)
        return selectableMonthRange.contains(currentMonth)
    }
}

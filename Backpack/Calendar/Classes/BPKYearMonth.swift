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

public struct BPKYearMonth {
    public let year: UInt
    public let month: UInt
    
    public init(year: UInt, month: UInt) {
        self.year = year
        self.month = month
    }
}

extension BPKYearMonth: Comparable {
    public static func < (lhs: BPKYearMonth, rhs: BPKYearMonth) -> Bool {
        if lhs.year <= rhs.year && lhs.month < rhs.month {
            return true
        }
        
        if lhs.year < rhs.year {
            return true
        }
        
        return false
    }
    
    public static func > (lhs: BPKYearMonth, rhs: BPKYearMonth) -> Bool {
        if lhs.year >= rhs.year && lhs.month > rhs.month {
            return true
        }
        
        if lhs.year > rhs.year {
            return true
        }
        
        return false
    }
    
    public static func == (lhs: BPKYearMonth, rhs: BPKYearMonth) -> Bool {
        if lhs.year == rhs.year && lhs.month == rhs.month {
            return true
        }
        
        return false
    }
    
    public static func <= (lhs: BPKYearMonth, rhs: BPKYearMonth) -> Bool {
        if lhs.year == rhs.year && lhs.month <= rhs.month {
            return true
        }
        
        if lhs.year < rhs.year {
            return true
        }
        
        return false
    }
    
    public static func >= (lhs: BPKYearMonth, rhs: BPKYearMonth) -> Bool {
        if lhs.year == rhs.year && lhs.month >= rhs.month {
            return true
        }
        
        if lhs.year > rhs.year {
            return true
        }
        
        return false
    }
}

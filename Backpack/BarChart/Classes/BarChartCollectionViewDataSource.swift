/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

import UIKit

@objc(BPKBarChartCollectionViewDataSource)
public protocol BPKBarChartCollectionViewDataSource {

    /// The number of bars to display in the section of the chart
    ///
    /// - parameter barChart: The BPKBarChart in question
    /// - parameter section: The section in question
    /// - returns: The number of bars in the section of the bar chart
    func barChart(_ barChart: BPKBarChart, numberOfBarsInSection section: Int) -> Int

    /// The number of sections to display in the chart
    ///
    /// - parameter barChart: The BPKBarChart in question
    /// - returns: The number of sections in the bar chart
    func numberOfSections(in barChart: BPKBarChart) -> Int

    /// The title to display above the section of the bar chart
    ///
    /// - parameter barChart: The BPKBarChart in question
    /// - parameter section: The section in question
    /// - returns: The title to display above the section of the bar chart
    func barChart(_ barChart: BPKBarChart, titleForSection section: Int) -> String

    /// The title to show underneath a specific bar
    ///
    /// - parameter barChart: The BPKBarChart in question
    /// - parameter atIndex: The index of the bar in question
    /// - returns: The title to display underneath the bar
    func barChart(_ barChart: BPKBarChart, titleForBarAtIndex atIndex: IndexPath) -> String

    /// The subtitle to show under the title of a specific bar
    ///
    /// - parameter barChart: The BPKBarChart in question
    /// - parameter atIndex: The index of the bar in question
    /// - returns: The subtitle to display underneath the bar
    func barChart(_ barChart: BPKBarChart, subtitleForBarAtIndex atIndex: IndexPath) -> String

    /// A value between 0.0 and 1.0 which represents the proportion of the bar to fill
    ///
    /// - parameter barChart: The BPKBarChart in question
    /// - parameter atIndex: The index of the bar in question
    /// - returns: The value between 0.0 and 1.0 which represents the proportion of the bar to fil
    func barChart(_ barChart: BPKBarChart, fillValueForBarAtIndex atIndex: IndexPath) -> NSNumber?

    /// The descriptive value for each bar, which will be shown to a user when they select the bar
    ///
    /// - parameter barChart: The BPKBarChart in question
    /// - parameter atIndex: The index of the bar in question
    /// - returns: A user-friendly description of the value represented by the bar
    func barChart(_ barChart: BPKBarChart, valueDescriptionForBarAtIndex atIndex: IndexPath) -> String
}

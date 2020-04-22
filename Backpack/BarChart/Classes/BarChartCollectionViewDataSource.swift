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

    /// The number of bars to display in the chart
    ///
    /// - parameter barChartCollectionView: The BPKBarChartCollectionView in question
    /// - returns: The number of bars in the bar chart
    func numberOfBarsInChart(barChartCollectionView: BPKBarChartCollectionView) -> Int

    /// The title to show underneath a specific bar
    ///
    /// - parameter barChartCollectionView: The BPKBarChartCollectionView in question
    /// - parameter atIndex: The index of the bar in question
    /// - returns: The title to display underneath the bar
    func titleForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: Int) -> String

    /// The subtitle to show under the title of a specific bar
    ///
    /// - parameter barChartCollectionView: The BPKBarChartCollectionView in question
    /// - parameter atIndex: The index of the bar in question
    /// - returns: The subtitle to display underneath the bar
    func subtitleForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: Int) -> String

    /// A value between 0.0 and 1.0 which represents the proportion of the bar to fill
    ///
    /// - parameter barChartCollectionView: The BPKBarChartCollectionView in question
    /// - parameter atIndex: The index of the bar in question
    /// - returns: The value between 0.0 and 1.0 which represents the proportion of the bar to fil
    func fillValueForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: Int) -> NSNumber?

    /// The descriptive value for each bar, which will be shown to a user when they select the bar
    ///
    /// - parameter barChartCollectionView: The BPKBarChartCollectionView in question
    /// - parameter atIndex: The index of the bar in question
    /// - returns: A user-friendly description of the value represented by the bar
    func valueDescriptionForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: Int) -> String
}

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
import Backpack

class BarChartsViewController: UIViewController {
    @IBOutlet weak var barChart: BPKBarChart!
    
    override func viewDidLoad() {
        self.barChart.barChartDataSource = self
        self.barChart.barChartDelegate = self
        self.barChart.title = "Departure date"
    }
}

extension BarChartsViewController: BPKBarChartCollectionViewDataSource {
    func titleForSection(barChartCollectionView: BPKBarChartCollectionView, section: Int) -> String {
        switch section {
        case 0:
            return "January"
        case 1:
            return "February"
        case 2:
            return "March"
        default:
            return "None"
        }
    }

    func numberOfSectionsInChart(barChartCollectionView: BPKBarChartCollectionView) -> Int {
        return 3
    }

    func numberOfBarsInSection(barChartCollectionView: BPKBarChartCollectionView, section: Int) -> Int {
        return 10
    }

    func titleForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: IndexPath) -> String {
        let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun",
                          "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        return daysOfWeek[atIndex.item]
    }

    func subtitleForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: IndexPath) -> String {
        return "\(atIndex.item + 1)"
    }

    func fillValueForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: IndexPath) -> NSNumber? {
        if atIndex.item == 0 {
            return nil
        }

        return NSNumber(value: Float(exactly: atIndex.item)! * 0.1)
    }

    func valueDescriptionForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: IndexPath) -> String {
        if atIndex.item == 0 {
            return "No price"
        }

        let value = (atIndex.item + 1) * 5
        return "£\(value)"
    }
}

extension BarChartsViewController: BPKBarChartCollectionViewDelegate {
    func didSelect(barChart: BPKBarChartCollectionView, index: IndexPath) {
        print("Selected bar at index \(index.item)")
    }
}

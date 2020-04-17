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
    func numberOfBarsInChart(barChartCollectionView: BPKBarChartCollectionView) -> Int {
        return 10
    }

    func titleForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: Int) -> String {
        let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun",
                          "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        return daysOfWeek[atIndex]
    }

    func subtitleForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: Int) -> String {
        return "\(atIndex + 1)"
    }

    func fillValueForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: Int) -> NSNumber? {
        if atIndex == 0 {
            return nil
        }

        return NSNumber(value: Float(exactly: atIndex)! * 0.1)
    }

    func valueDescriptionForBar(barChartCollectionView: BPKBarChartCollectionView, atIndex: Int) -> String {
        if atIndex == 0 {
            return "No price"
        }

        let value = (atIndex + 1) * 5
        return "£\(value)"
    }
}

extension BarChartsViewController: BPKBarChartCollectionViewDelegate {
    func didSelect(barChart: BPKBarChartCollectionView, index: Int) {
        print("Selected bar at index \(index)")
    }
}

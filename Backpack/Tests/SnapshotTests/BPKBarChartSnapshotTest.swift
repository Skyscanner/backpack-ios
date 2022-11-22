/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

import XCTest
import Backpack
import SnapshotTesting

final class BPKBarChartSnapshotTest: XCTestCase {
    
    var sut: BPKBarChart!
    var dataSource: BPKBarChartCollectionViewDataSource!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false

        dataSource = MockBarChartDataSource()
        
        sut = BPKBarChart(title: "Departure", dataKeyText: "Price", noDataKeyText: "No price")
        sut.barChartDataSource = dataSource
        sut.translatesAutoresizingMaskIntoConstraints = false
        sut.backgroundColor = BPKColor.canvasColor
        
        NSLayoutConstraint.activate([
            sut.heightAnchor.constraint(equalToConstant: 500),
            sut.widthAnchor.constraint(equalToConstant: 500)
        ])
    }

    override func tearDownWithError() throws {
        dataSource = nil
        try? super.tearDownWithError()
    }
    
    func testBarChartDefault() {
        assertSnapshot(sut)
    }
    
    func testBarChartDefaultSelected() {
        // Given
        sut.selectedIndexPath = IndexPath(item: 2, section: 0)
        
        // Then
        assertSnapshot(sut)
    }
}

// MARK: Datasource helper
final class MockBarChartDataSource: BPKBarChartCollectionViewDataSource {
    func barChart(_ barChart: Backpack.BPKBarChart, numberOfBarsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in barChart: Backpack.BPKBarChart) -> Int {
        return 2
    }
    
    func barChart(_ barChart: Backpack.BPKBarChart, titleForSection section: Int) -> String {
        switch section {
        case 0:
            return "January"
        case 1:
            return "February"
        default:
            return "None"
        }
    }
    
    func barChart(_ barChart: Backpack.BPKBarChart, titleForBarAtIndex atIndex: IndexPath) -> String {
        let weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        return weekDays[atIndex.item % 7]
    }
    
    func barChart(_ barChart: Backpack.BPKBarChart, subtitleForBarAtIndex atIndex: IndexPath) -> String {
        return "\(atIndex.item + 1)"
    }
    
    func barChart(_ barChart: Backpack.BPKBarChart, fillValueForBarAtIndex atIndex: IndexPath) -> NSNumber? {
        if atIndex.item == 0 {
            return nil
        }
        
        return Double(atIndex.item) * 0.1 as NSNumber
    }
    
    func barChart(_ barChart: Backpack.BPKBarChart, valueDescriptionForBarAtIndex atIndex: IndexPath) -> String {
        if atIndex.item == 0 {
            return "No price"
        }
        
        return "£\(atIndex.item + 1)"
    }
}

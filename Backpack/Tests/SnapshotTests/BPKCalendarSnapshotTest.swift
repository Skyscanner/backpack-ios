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

import XCTest
import Backpack
import SnapshotTesting

final class BPKCalendarSnapshotTest: XCTestCase {
    
    let date1 = Date(timeIntervalSince1970: 2175767888)
    let date2 = Date(timeIntervalSince1970: 2176026888)
    let date3 = Date(timeIntervalSince1970: 2177754888)
    let date4 = Date(timeIntervalSince1970: 2188122888)
    
    var isColoringDates: Bool!
    var isShowingPrices: Bool!
    
    var sut: BPKCalendar!
    var snapshotView: UIView!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        isRecording = false
    
        isColoringDates = false
        isShowingPrices = false
        
        sut = BPKCalendar()
        setupViews()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        snapshotView = nil
        try? super.tearDownWithError()
    }
    
    func testCalendarWithoutSelection() {
        // Given
        sut.selectionConfiguration = BPKCalendarSelectionConfigurationSingle(selectionHint: "")
        sut.selectedDates = [BPKSimpleDate(date: date1, for: sut.gregorian)]
        
        // When
        sut.reloadData()
        sut.selectedDates = []
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    // MARK: Helpers
    private func setupViews() {
        snapshotView = UIView()
        snapshotView.backgroundColor = BPKColor.canvasColor
        
        [sut, snapshotView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        snapshotView.addSubview(sut)
        
        let screenSize = CGSize(width: 375, height: 667) // iPhone 8 screen dimensions
        NSLayoutConstraint.activate([
            snapshotView.widthAnchor.constraint(equalToConstant: screenSize.width),
            snapshotView.heightAnchor.constraint(equalToConstant: screenSize.height),
            
            sut.leadingAnchor.constraint(equalTo: snapshotView.leadingAnchor),
            sut.topAnchor.constraint(equalTo: snapshotView.topAnchor),
            sut.trailingAnchor.constraint(equalTo: snapshotView.trailingAnchor),
            sut.bottomAnchor.constraint(equalTo: snapshotView.bottomAnchor)
        ])
        
        snapshotView.layoutIfNeeded()
    }
}

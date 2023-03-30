/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2023 Skyscanner Ltd
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

final class BPKFlightLegSnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    private static let defaultDescription: NSAttributedString =
        NSAttributedString(string: "LHR-SIN, SwissAir", attributes: BPKFlightLeg.descriptionDefaultAttributes)
    
    private let highlightedDescription: NSAttributedString = {
        let flightDescriptionString = NSMutableAttributedString(
            string: "LHR-SIN, SwissAir", attributes: BPKFlightLeg.descriptionDefaultAttributes)
        let range = (flightDescriptionString.string as NSString).range(of: "SIN")
        flightDescriptionString.addAttributes(BPKFlightLeg.airportHighlightAttributes, range: range)
        
        return flightDescriptionString
    }()
    
    private func createFlightLegView(
        departureArrivalTime: String = "19:51 - 22:45",
        nextDayArrival: String? = nil,
        flightDescription: NSAttributedString = defaultDescription,
        stopsInfo: String = "Direct",
        highlightStopsInfo: Bool = false,
        duration: String = "7h 55m",
        operatedBy: String? = nil,
        warning: String? = nil,
        carrierLogo: BPKIconName = .airline
    ) -> UIView {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = BPKColor.surfaceDefaultColor
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        let flightLeg = BPKFlightLeg(
            departureArrivalTime: departureArrivalTime,
            nextDayArrival: nextDayArrival,
            flightDescription: flightDescription,
            stopsInfo: stopsInfo,
            highlightStopsInfo: highlightStopsInfo,
            duration: duration,
            operatedBy: operatedBy,
            warning: warning,
            carrierLogo: carrierLogo
        )
        
        flightLeg.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(flightLeg)
        
        NSLayoutConstraint.activate([
            flightLeg.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
            flightLeg.leadingAnchor.constraint(
                equalTo: parentView.safeAreaLayoutGuide.leadingAnchor,
                constant: BPKSpacingBase
            ),
            flightLeg.trailingAnchor.constraint(
                equalTo: parentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -BPKSpacingBase
            ),
            flightLeg.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor),
            parentView.widthAnchor.constraint(equalToConstant: 375)
        ])

        return parentView
    }
    
    func testBPKFlightLegSnapshotDefaultDescription() {
        let flightLegStackView = createFlightLegView()
        assertSnapshot(flightLegStackView)
    }

    func testBPKFlightLegWithExtraStops() {
        let flightLegStackView = createFlightLegView(
            stopsInfo: "2 Stops",
            highlightStopsInfo: true
        )
        assertSnapshot(flightLegStackView)
    }
    
    func testBPKFlightLegWithCompleteDescription() {
        let flightLegStackView = createFlightLegView(
            nextDayArrival: "+1",
            flightDescription: highlightedDescription,
            stopsInfo: "2 Stops",
            highlightStopsInfo: true,
            operatedBy: "Operated by WestJet",
            warning: "Change airports in London",
            carrierLogo: .airline
        )
        assertSnapshot(flightLegStackView)
    }
    
    func testBPKFlightLegWithCompleteLongStopsInfoDescription() {
        let flightLegStackView = createFlightLegView(
            departureArrivalTime: "19:53 - 22:45",
            nextDayArrival: "+2",
            flightDescription: highlightedDescription,
            stopsInfo: "2 Zwischenlandungen",
            highlightStopsInfo: true,
            duration: "7h 55m",
            operatedBy: "Operated by WestJet",
            warning: "Change airports in London",
            carrierLogo: .airlineMultiple
        )
        assertSnapshot(flightLegStackView)
    }
    
    func testBPKFlightLegWithCompleteLongDescription() {
        let flightLegStackView = createFlightLegView(
            departureArrivalTime: "19:53 - 22:45",
            nextDayArrival: "+2",
            flightDescription: highlightedDescription,
            stopsInfo: "2 Stops",
            highlightStopsInfo: true,
            duration: "7h 55m",
            operatedBy: "Operated by WestJet Operated by WestJet Operated" +
            "by WestJet Operated by WestJet Operated by WestJet",
            warning: "Change airports in London",
            carrierLogo: .airlineMultiple
        )
        assertSnapshot(flightLegStackView)
    }
    
    func testBPKFlightLegWithCompleteArabicDescription() {
        let flightLegStackView = createFlightLegView(
            departureArrivalTime: "6:35 ص - 11:20 م",
            nextDayArrival: "+2",
            flightDescription: highlightedDescription,
            stopsInfo: "1 محطة توقف",
            highlightStopsInfo: true,
            duration: "نس 10د",
            operatedBy: "Operated by WestJet",
            warning: "Change airports in London",
            carrierLogo: .airlineMultiple
        )
        assertSnapshot(flightLegStackView)
    }
}

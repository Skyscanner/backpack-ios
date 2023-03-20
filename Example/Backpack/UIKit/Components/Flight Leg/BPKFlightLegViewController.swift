//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

import Foundation
import UIKit
import Backpack

class BPKFlightLegViewController: UIViewController {
    private let samplteAttributedDefaultDescription: NSAttributedString = {
        let fontAttribute: [NSAttributedString.Key: Any] = [.font: BPKFont.makeFont(fontStyle: .textCaption)]
        return NSAttributedString(string: "LHR-SIN, SwissAir", attributes: fontAttribute)
    }()
    
    private let sampleAttributedCompleteDescription: NSAttributedString = {
        let fontAttribute: [NSAttributedString.Key: Any] = [.font: BPKFont.makeFont(fontStyle: .textCaption)]
        let highlightAttribute: [NSAttributedString.Key: Any] = [
            .backgroundColor: BPKColor.statusDangerFillColor,
            .font: BPKFont.makeFont(fontStyle: .textCaption)
        ]
        let originAirportString = NSMutableAttributedString(string: "LHR", attributes: highlightAttribute)
        let remainingString = NSAttributedString(string: "-SIN, SwissAir", attributes: fontAttribute)
        
        originAirportString.append(remainingString)
        return originAirportString
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.surfaceDefaultColor
        setupView()
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = BPKSpacingBase
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(createHeader("Basic Flight Leg"))
        stackView.addArrangedSubview(createFlightLeg(
            departureArrivalTime: "19:51 - 22:45",
            flightDescription: samplteAttributedDefaultDescription,
            stopsInfo: "Direct",
            duration: "7h 55m",
            carrierLogo: .airline
        ))
        
        stackView.addArrangedSubview(createHeader("Complete Flight Leg"))
        stackView.addArrangedSubview(createFlightLeg(
            departureArrivalTime: "19:53 - 22:45",
            nextDayArrival: "+2",
            flightDescription: sampleAttributedCompleteDescription,
            stopsInfo: "2 stops",
            highlightStopsInfo: true,
            duration: "7h 55m",
            operatedBy: "Operated by WestJet",
            warning: "Change airports in London",
            carrierLogo: .airlineMultiple
        ))
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: BPKSpacingBase),
            stackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -BPKSpacingBase)
        ])
    }
    
    private func createFlightLeg(
        departureArrivalTime: String,
        nextDayArrival: String? = nil,
        flightDescription: NSAttributedString,
        stopsInfo: String,
        highlightStopsInfo: Bool = false,
        duration: String,
        operatedBy: String? = nil,
        warning: String? = nil,
        carrierLogo: BPKIconName
    ) -> BPKFlightLeg {
        
        return BPKFlightLeg(
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
    }
    
    private func createHeader(_ text: String) -> BPKLabel {
        let label = BPKLabel(fontStyle: .textHeading4)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

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
    private let defaultDescription: NSAttributedString = {
        NSAttributedString(string: "LHR-SIN, SwissAir", attributes: BPKFlightLeg.descriptionDefaultAttributes)
    }()
    
    private let highlightedDescription: NSAttributedString = {
        let flightDescriptionString = NSMutableAttributedString(
            string: "LHR-SIN, SwissAir", attributes: BPKFlightLeg.descriptionDefaultAttributes)
        let range = (flightDescriptionString.string as NSString).range(of: "SIN")
        flightDescriptionString.addAttributes(BPKFlightLeg.airportHighlightAttributes, range: range)
        
        return flightDescriptionString
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.surfaceDefaultColor
        setupView()
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = BPKSpacingBase
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(createHeader("Basic Flight Leg"))
        stackView.addArrangedSubview(createSampleFlightLeg())
        
        stackView.addArrangedSubview(createHeader("Complete Flight Leg"))
        stackView.addArrangedSubview(createCompleteFlightLeg())
        
        stackView.addArrangedSubview(createHeader("Complete Flight Leg /w Long Desc"))
        stackView.addArrangedSubview(createCompleteFlightLegWithLongDescription())

        stackView.addArrangedSubview(createHeader("Complete Flight Leg /w Long Stops"))
        stackView.addArrangedSubview(createCompleteFlightLegWithLongStopsInfo())
        
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
        carrierLogo: UIImage? = nil
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
    
    private func createSampleFlightLeg() -> UIView {
        return createFlightLeg(
            departureArrivalTime: "19:50 - 22:45",
            flightDescription: defaultDescription,
            stopsInfo: "Direct",
            duration: "7h 55m",
            carrierLogo: BPKIcon.makeLargeIcon(name: .airline, color: .bpk_black)
        )
    }
    
    private func createCompleteFlightLeg() -> UIView {
        return createFlightLeg(
            departureArrivalTime: "19:50 - 22:45",
            nextDayArrival: "+2",
            flightDescription: highlightedDescription,
            stopsInfo: "2 Stops",
            highlightStopsInfo: true,
            duration: "7h 55m",
            operatedBy: "Operated by WestJet",
            warning: "Change airports in London",
            carrierLogo: BPKIcon.makeLargeIcon(name: .airlineMultiple, color: .bpk_black)
        )
    }
    
    private func createCompleteFlightLegWithLongDescription() -> UIView {
        return createFlightLeg(
            departureArrivalTime: "19:50 - 22:45",
            nextDayArrival: "+2",
            flightDescription: highlightedDescription,
            stopsInfo: "2 Stops",
            highlightStopsInfo: true,
            duration: "7h 55m",
            operatedBy: "Operated by WestJet Operated by WestJet Operated" +
            "by WestJet Operated by WestJet Operated by WestJet",
            warning: "Change airports in London",
            carrierLogo: BPKIcon.makeLargeIcon(name: .airlineMultiple, color: .bpk_black)
        )
    }
    
    private func createCompleteFlightLegWithLongStopsInfo() -> UIView {
        return createFlightLeg(
            departureArrivalTime: "19:50 - 22:45",
            nextDayArrival: "+2",
            flightDescription: highlightedDescription,
            stopsInfo: "2 Zwischenlandungen",
            highlightStopsInfo: true,
            duration: "7h 55m",
            operatedBy: "Operated by WestJet",
            warning: "Change airports in London",
            carrierLogo: BPKIcon.makeLargeIcon(name: .airlineMultiple, color: .bpk_black)
        )
    }
    
    private func createHeader(_ text: String) -> BPKLabel {
        let label = BPKLabel(fontStyle: .textHeading4)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

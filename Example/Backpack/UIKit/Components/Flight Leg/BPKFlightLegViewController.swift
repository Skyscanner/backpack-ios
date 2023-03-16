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
// swiftlint:disable superfluous_disable_command
// swiftlint:disable trailing_whitespace
// swiftlint:disable comment_spacing
import Foundation
import UIKit
import Backpack

class BPKFlightLegViewController: UIViewController {
    private let departureArrivalTime: BPKLabel // heading5
    //private let nextDayArrival: BPKLabel // caption <-
    private let flightDescription: BPKLabel
    
    private let stopsInfo: BPKLabel // hug
    //private let highlightStopsInfo //
    private let duration: BPKLabel // hug
    //private let operatedBy: BPKLabel //
    //private let warning: BPKLabel //
    private let carrierLogo: BPKLargeIconView
    
    init() {
        self.departureArrivalTime = BPKLabel(fontStyle: .textHeading5)
        departureArrivalTime.text = "19:50 - 22:45"
        
        self.flightDescription = BPKLabel(fontStyle: .textCaption)
        flightDescription.text = "LHR-SIN, SwissAir"
        
        self.stopsInfo = BPKLabel(fontStyle: .textLabel3)
        stopsInfo.text = "Direct"
        
        self.duration = BPKLabel(fontStyle: .textCaption)
        duration.text = "7h 55m"
        
        self.carrierLogo = BPKLargeIconView(iconName: .airline)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        stackView.addArrangedSubview(createFlightLeg())
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func createFlightLeg(
        airportHighlight: [Int]? = nil,
        operatedBy: BPKLabel? = nil,
        nextDayArrival: BPKLabel? = nil,
        stops: BPKLabel? = nil,
        changeAirports: BPKLabel? = nil,
        nonBrandedAirline: Bool? = nil,
        multipleAirlines: Bool? = nil) -> BPKFlightLeg {
            
        return BPKFlightLeg(
            departureArrivalTime: "19:50 - 22:45",
            flightDescription: "LHR-SIN, SwissAir",
            stopsInfo: "Direct",
            duration: "7h 55m",
            carrierLogo: .airline
        )
    }
    
}

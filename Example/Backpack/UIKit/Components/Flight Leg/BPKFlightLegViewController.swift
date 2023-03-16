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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.alignment = .leading
        stack.spacing = BPKSpacingBase
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.surfaceDefaultColor
        setupView()
    }
    
    private func setupView() {
        horizontalStack.addArrangedSubview(setupCarrierLogoStackView(logo: carrierLogo))
        horizontalStack.addArrangedSubview(
            setupFlightStackView(components: [departureArrivalTime, flightDescription]))
        horizontalStack.addArrangedSubview(setupDurationStackView(components: [stopsInfo, duration]))
        
        view.addSubview(horizontalStack)
        
        NSLayoutConstraint.activate([
            //horizontalStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            horizontalStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func setupCarrierLogoStackView(logo: BPKLargeIconView) -> UIView {
        let logoView = UIStackView()
        logoView.alignment = .leading
        logoView.addArrangedSubview(logo)
        
//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(logoView)
//
//        NSLayoutConstraint.activate([
//            logoView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: BPKSpacingSm),
//            logoView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
//        ])
        return logoView//containerView
    }
    
    private func setupFlightStackView(components: [BPKLabel]) -> UIView {
        let verticalStackView = UIStackView()
        verticalStackView.alignment = .leading
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        components.forEach(verticalStackView.addArrangedSubview(_:))
        return verticalStackView
    }
    
    private func setupDurationStackView(components: [BPKLabel]) -> UIView {
        let verticalStackView = UIStackView()
        verticalStackView.alignment = .trailing
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        components.forEach(verticalStackView.addArrangedSubview(_:))
        return verticalStackView
    }
}

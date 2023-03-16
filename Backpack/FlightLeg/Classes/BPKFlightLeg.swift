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

public final class BPKFlightLeg: UIView {
    private var departureArrivalTime: String
    private var flightDescription: String
    private var stopsInfo: String
    private var duration: String
    private var carrierLogo: BPKIconName
    
    private let departureArrivalTimeLabel = BPKLabel()
    private let flightDescriptionLabel = BPKLabel()
    private let stopsInfoLabel = BPKLabel()
    private let durationLabel = BPKLabel()
    private let carrierLogoIcon = BPKLargeIconView()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = BPKSpacingBase
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let carrierLogoStackView: UIStackView = {
        let logoView = UIStackView()
        logoView.alignment = .leading
        logoView.translatesAutoresizingMaskIntoConstraints = false
        return logoView
    }()
    
    private let flightStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.alignment = .leading
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        return verticalStackView
    }()
    
    private let durationStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.alignment = .trailing
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        return verticalStackView
    }()
    
    public init(
        departureArrivalTime: String,
        flightDescription: String,
        stopsInfo: String,
        duration: String,
        carrierLogo: BPKIconName
    ) {
        self.departureArrivalTime = departureArrivalTime
        self.flightDescription = flightDescription
        self.stopsInfo = stopsInfo
        self.duration = duration
        self.carrierLogo = carrierLogo
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        containerStackView.addArrangedSubview(setupCarrierLogo())
        containerStackView.addArrangedSubview(setupFlightStackView())
        containerStackView.addArrangedSubview(setupDurationStackView())
        
        addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupCarrierLogo() -> UIView {
        
        let verticalStackView = UIView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        carrierLogoIcon.iconName = carrierLogo
        carrierLogoStackView.addArrangedSubview(carrierLogoIcon)
        verticalStackView.addSubview(carrierLogoStackView)
        
        NSLayoutConstraint.activate([
            carrierLogoStackView.topAnchor.constraint(equalTo: verticalStackView.topAnchor, constant: BPKSpacingSm),
            carrierLogoStackView.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor),
            carrierLogoStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            carrierLogoStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor)
        ])
        
        return verticalStackView
    }
    
    private func setupFlightStackView() -> UIView {
        departureArrivalTimeLabel.fontStyle = .textHeading5
        departureArrivalTimeLabel.textColor = BPKColor.textPrimaryColor
        departureArrivalTimeLabel.text = departureArrivalTime
        
        flightDescriptionLabel.fontStyle = .textCaption
        flightDescriptionLabel.textColor = BPKColor.textPrimaryColor
        flightDescriptionLabel.text = flightDescription
        
        [departureArrivalTimeLabel, flightDescriptionLabel].forEach(flightStackView.addArrangedSubview(_:))
        return flightStackView
    }
    
    private func setupDurationStackView() -> UIView {
        stopsInfoLabel.fontStyle = .textLabel3
        stopsInfoLabel.textColor = BPKColor.textPrimaryColor
        stopsInfoLabel.text = stopsInfo
        
        durationLabel.fontStyle = .textCaption
        durationLabel.textColor = BPKColor.textPrimaryColor
        durationLabel.text = duration
        
        [stopsInfoLabel, durationLabel].forEach(durationStackView.addArrangedSubview(_:))
        return durationStackView
    }
}

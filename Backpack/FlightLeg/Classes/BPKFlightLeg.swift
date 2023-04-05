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
    private let departureArrivalTime: String
    private let nextDayArrival: String?
    private let flightDescription: NSAttributedString
    private let stopsInfo: String
    private let highlightStopsInfo: Bool
    private let duration: String
    private let operatedBy: String?
    private let warning: String?
    private let carrierLogo: UIImage?
    
    private let departureArrivalTimeLabel: BPKLabel = {
        let departureArrtvalTimeLabel = BPKLabel()
        departureArrtvalTimeLabel.fontStyle = .textHeading5
        departureArrtvalTimeLabel.textColor = BPKColor.textPrimaryColor
        departureArrtvalTimeLabel.lineBreakMode = .byWordWrapping
        return departureArrtvalTimeLabel
    }()
    private let flightDescriptionLabel: BPKLabel = {
        let flightDescriptionLabel = BPKLabel()
        flightDescriptionLabel.fontStyle = .textCaption
        flightDescriptionLabel.textColor = BPKColor.textPrimaryColor
        flightDescriptionLabel.lineBreakMode = .byWordWrapping
        return flightDescriptionLabel
    }()
    private let stopsInfoLabel: BPKLabel = {
        let stopsInfoLabel = BPKLabel()
        stopsInfoLabel.fontStyle = .textLabel3
        stopsInfoLabel.textColor = BPKColor.textPrimaryColor
        stopsInfoLabel.lineBreakMode = .byWordWrapping
        return stopsInfoLabel
    }()
    private let durationLabel: BPKLabel = {
        let durationLabel = BPKLabel()
        durationLabel.fontStyle = .textCaption
        durationLabel.textColor = BPKColor.textPrimaryColor
        durationLabel.lineBreakMode = .byWordWrapping
        return durationLabel
    }()
    private let operatedByLabel: BPKLabel = {
        let operatedByLabel = BPKLabel()
        operatedByLabel.fontStyle = .textCaption
        operatedByLabel.textColor = BPKColor.textPrimaryColor
        operatedByLabel.numberOfLines = 0
        operatedByLabel.lineBreakMode = .byWordWrapping
        return operatedByLabel
    }()
    private let warningLabel: BPKLabel = {
        let warningLabel = BPKLabel()
        warningLabel.fontStyle = .textLabel3
        warningLabel.textColor = BPKColor.textErrorColor
        warningLabel.lineBreakMode = .byWordWrapping
        return warningLabel
    }()
    private let carrierLogoIcon: UIImageView = {
        let carrierLogoIcon = UIImageView()
        carrierLogoIcon.tintColor = BPKColor.textOnLightColor
        return carrierLogoIcon
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = BPKSpacingBase
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    public init(
        departureArrivalTime: String,
        nextDayArrival: String?,
        flightDescription: NSAttributedString,
        stopsInfo: String,
        highlightStopsInfo: Bool = false,
        duration: String,
        operatedBy: String?,
        warning: String?,
        carrierLogo: UIImage?
    ) {
        self.departureArrivalTime = departureArrivalTime
        self.nextDayArrival = nextDayArrival
        self.flightDescription = flightDescription
        self.stopsInfo = stopsInfo
        self.highlightStopsInfo = highlightStopsInfo
        self.duration = duration
        self.operatedBy = operatedBy
        self.warning = warning
        self.carrierLogo = carrierLogo
        
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        containerStackView.addArrangedSubview(createCarrierLogo())
        containerStackView.addArrangedSubview(createFlightStackView())
        containerStackView.addArrangedSubview(createDurationStackView())
    }
    
    private func setupConstraints() {
        addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func createCarrierLogo() -> UIView {
        let leadingStackView = UIStackView()
        leadingStackView.alignment = .leading
        leadingStackView.translatesAutoresizingMaskIntoConstraints = false
        leadingStackView.layer.cornerRadius = BPKCornerRadiusXs
        leadingStackView.spacing = BPKSpacingSm
        leadingStackView.backgroundColor = BPKColor.textOnDarkColor
        
        let verticalStackView = UIView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        carrierLogoIcon.image = carrierLogo
        leadingStackView.addArrangedSubview(carrierLogoIcon)
        verticalStackView.addSubview(leadingStackView)
        
        NSLayoutConstraint.activate([
            leadingStackView.topAnchor.constraint(equalTo: verticalStackView.topAnchor, constant: BPKSpacingSm),
            leadingStackView.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor),
            leadingStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            leadingStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            
            carrierLogoIcon.widthAnchor.constraint(equalToConstant: 24),
            carrierLogoIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
        return verticalStackView
    }
    
    private func createFlightStackView() -> UIView {
        let middleStackView = UIStackView()
        middleStackView.alignment = .leading
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.axis = .vertical
        
        departureArrivalTimeLabel.attributedText = createCompleteDepartureArrivalTimeLabel()
        middleStackView.addArrangedSubview(departureArrivalTimeLabel)
        
        flightDescriptionLabel.attributedText = flightDescription
        middleStackView.addArrangedSubview(flightDescriptionLabel)
        
        if operatedBy != nil {
            operatedByLabel.text = operatedBy
            middleStackView.addArrangedSubview(operatedByLabel)
        }
        
        if warning != nil {
            warningLabel.text = warning
            middleStackView.addArrangedSubview(warningLabel)
        }
        
        return middleStackView
    }
    
    private func createCompleteDepartureArrivalTimeLabel() -> NSMutableAttributedString {
        let departureArrivalTimeAttributes: [NSAttributedString.Key: Any] =
            [.font: BPKFont.makeFont(fontStyle: .textHeading5)]
        let departureArrivalTimeString = NSMutableAttributedString(
            string: departureArrivalTime, attributes: departureArrivalTimeAttributes)
        
        if nextDayArrival != nil {
            let nextDayArrivalAttributes: [NSAttributedString.Key: Any] =
            [.font: BPKFont.makeFont(fontStyle: .textCaption), .baselineOffset: 4]
            let nextDayArrivalString = NSMutableAttributedString(
                string: nextDayArrival ?? "", attributes: nextDayArrivalAttributes)
            departureArrivalTimeString.append(nextDayArrivalString)
        }
        
        return departureArrivalTimeString
    }
    
    public static var airportHighlightAttributes: [NSAttributedString.Key: Any] {
        [
            .backgroundColor: BPKColor.statusDangerFillColor,
            .font: BPKFont.makeFont(fontStyle: .textCaption),
            .foregroundColor: BPKColor.textOnLightColor
        ]
    }
    
    public static var descriptionDefaultAttributes: [NSAttributedString.Key: Any] {
        [.font: BPKFont.makeFont(fontStyle: .textCaption)]
    }
    
    private func createDurationStackView() -> UIView {
        let trailingStackView = UIStackView()
        trailingStackView.alignment = .trailing
        trailingStackView.translatesAutoresizingMaskIntoConstraints = false
        trailingStackView.axis = .vertical
    
        stopsInfoLabel.text = stopsInfo
        stopsInfoLabel.textColor = highlightStopsInfo ? BPKColor.textErrorColor : BPKColor.textPrimaryColor
        
        durationLabel.text = duration
        
        [stopsInfoLabel, durationLabel].forEach(trailingStackView.addArrangedSubview(_:))
        trailingStackView.spacing = BPKSpacingSm
        return trailingStackView
    }
}

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
    private var nextDayArrival: String?
    private var flightDescription: NSAttributedString
    private var stopsInfo: String
    private var highlightStopsInfo: Bool = false
    private var duration: String
    private var operatedBy: String?
    private var warning: String?
    private var carrierLogo: BPKIconName
    
    private let departureArrivalTimeLabel: BPKLabel = {
        let departureArrtvalTimeLabel = BPKLabel()
        departureArrtvalTimeLabel.fontStyle = .textHeading5
        departureArrtvalTimeLabel.textColor = BPKColor.textPrimaryColor
        return departureArrtvalTimeLabel
    }()
    private let flightDescriptionLabel: BPKLabel = {
        let flightDescriptionLabel = BPKLabel()
        flightDescriptionLabel.fontStyle = .textCaption
        flightDescriptionLabel.textColor = BPKColor.textPrimaryColor
        return flightDescriptionLabel
    }()
    private let stopsInfoLabel: BPKLabel = {
        let stopsInfoLabel = BPKLabel()
        stopsInfoLabel.fontStyle = .textLabel3
        stopsInfoLabel.textColor = BPKColor.textPrimaryColor
        return stopsInfoLabel
    }()
    private let highlightStopsInfoDefaultValue = false
    private let durationLabel: BPKLabel = {
        let durationLabel = BPKLabel()
        durationLabel.fontStyle = .textCaption
        durationLabel.textColor = BPKColor.textPrimaryColor
        return durationLabel
    }()
    private let operatedByLabel: BPKLabel = {
        let operatedByLabel = BPKLabel()
        operatedByLabel.fontStyle = .textCaption
        operatedByLabel.textColor = BPKColor.textPrimaryColor
        operatedByLabel.numberOfLines = 0
        return operatedByLabel
    }()
    private let warningLabel: BPKLabel = {
        let warningLabel = BPKLabel()
        warningLabel.fontStyle = .textLabel3
        warningLabel.textColor = BPKColor.textErrorColor
        return warningLabel
    }()
    private let carrierLogoIcon: BPKLargeIconView = {
        let carrierLogoIcon = BPKLargeIconView()
        carrierLogoIcon.tintColor = BPKColor.textPrimaryColor
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
    
    private let leadingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let trailingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let flightTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    public init(
        departureArrivalTime: String,
        nextDayArrival: String?,
        flightDescription: NSAttributedString,
        stopsInfo: String,
        highlightStopsInfo: Bool,
        duration: String,
        operatedBy: String?,
        warning: String?,
        carrierLogo: BPKIconName
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
        leadingStackView.addArrangedSubview(carrierLogoIcon)
        verticalStackView.addSubview(leadingStackView)
        
        NSLayoutConstraint.activate([
            leadingStackView.topAnchor.constraint(equalTo: verticalStackView.topAnchor, constant: BPKSpacingSm),
            leadingStackView.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor),
            leadingStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            leadingStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor)
        ])
        return verticalStackView
    }
    
    private func setupFlightStackView() -> UIView {
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
        departureArrivalTimeLabel.attributedText = departureArrivalTimeString
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
    
    public static func airportHighlightAttributes() -> [NSAttributedString.Key: Any] {
        return [
            .backgroundColor: BPKColor.statusDangerFillColor,
            .font: BPKFont.makeFont(fontStyle: .textCaption),
            .foregroundColor: BPKColor.textOnLightColor
        ]
    }
    
    public static func descriptionDefaultAttributes() -> [NSAttributedString.Key: Any] {
        return [.font: BPKFont.makeFont(fontStyle: .textCaption)]
    }
    
    private func setupDurationStackView() -> UIView {
        stopsInfoLabel.text = stopsInfo
        stopsInfoLabel.textColor = highlightStopsInfo ? BPKColor.textErrorColor : BPKColor.textPrimaryColor
        
        durationLabel.text = duration
        
        [stopsInfoLabel, durationLabel].forEach(trailingStackView.addArrangedSubview(_:))
        trailingStackView.spacing = BPKSpacingSm
        return trailingStackView
    }
}

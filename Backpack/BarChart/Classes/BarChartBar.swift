/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

import UIKit

@objcMembers
@objc(BPKBarChartBar)
public final class BPKBarChartBar: UIControl {

    let backgroundView: UIView = UIView()
    let barView: UIView = UIView()
    let miniFlareView: BPKMiniFlareView = BPKMiniFlareView()
    let titleLabel: BPKLabel = BPKLabel(fontStyle: .textBaseEmphasized)
    let subtitleLabel: BPKLabel = BPKLabel(fontStyle: .textSm)
    var barViewHeightAnchor: NSLayoutConstraint?
    var miniFlareViewPositionAnchor: NSLayoutConstraint?
    let backgroundViewColor = BPKColor.dynamicColor(withLightVariant: BPKColor.skyGrayTint06,
                                                    darkVariant: BPKColor.blackTint03)
    let noPriceColor = BPKColor.skyGrayTint03
    let priceColor = BPKColor.primaryColor
    let selectedColor = BPKColor.dynamicColor(withLightVariant: BPKColor.monteverde, darkVariant: BPKColor.glencoe)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }

    func setupViews() {
        self.backgroundView.backgroundColor = self.backgroundViewColor
        self.barView.backgroundColor = noPriceColor

        self.addSubview(self.backgroundView)
        self.addSubview(self.barView)
        self.addSubview(self.miniFlareView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)

        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.barView.translatesAutoresizingMaskIntoConstraints = false
        self.miniFlareView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundView.layer.cornerRadius = BPKSpacingMd
        self.barView.layer.cornerRadius = BPKSpacingMd

        NSLayoutConstraint.activate([
            self.backgroundView.widthAnchor.constraint(equalToConstant: BPKSpacingBase),
            self.barView.widthAnchor.constraint(equalToConstant: BPKSpacingBase),
            self.barView.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor),
            self.barView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.miniFlareView.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.subtitleLabel.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: BPKSpacingMd),
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: BPKSpacingMd),
            self.bottomAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: BPKSpacingMd)
        ])
        self.updateBarHeight()
        self.updateminiFlareViewAppearance()
    }

    func updateBarColor() {
        if self.isSelected {
            barView.backgroundColor = self.selectedColor
            titleLabel.textColor = self.selectedColor
            subtitleLabel.textColor = self.selectedColor
            return
        }

        titleLabel.textColor = BPKColor.textPrimaryColor
        subtitleLabel.textColor = BPKColor.textPrimaryColor

        if self.privateFillValue == nil {
            barView.backgroundColor = self.noPriceColor
        } else {
            barView.backgroundColor = self.priceColor
        }
    }

    func updateBarHeight() {
        if self.barViewHeightAnchor != nil {
            self.barViewHeightAnchor!.isActive = false
        }

        if self.privateFillValue == nil {
            self.barViewHeightAnchor = self.barView.heightAnchor.constraint(equalToConstant: BPKSpacingLg)
        } else {
            self.barViewHeightAnchor = self.barView.heightAnchor.constraint(equalTo: self.backgroundView.heightAnchor,
                                                                            multiplier: self.privateFillValue!)
        }

        self.barViewHeightAnchor!.isActive = true
    }

    func updateminiFlareViewAppearance() {
        if self.miniFlareViewPositionAnchor != nil {
            self.miniFlareViewPositionAnchor!.isActive = false
        }

        self.miniFlareViewPositionAnchor = self.miniFlareView.bottomAnchor.constraint(equalTo: self.barView.topAnchor,
                                                                                      constant: -BPKSpacingSm)

        self.miniFlareViewPositionAnchor!.isActive = true

        self.miniFlareView.isHidden = self.realValue == nil || !self.isSelected
    }

    public override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.isSelected = newValue
            self.updateBarColor()
            self.updateminiFlareViewAppearance()
        }
    }

    private var privateFillValue: CGFloat?
    public var fillValue: CGFloat {
        get {
            return privateFillValue == nil ? -1 : 0
        }
        set {
            self.privateFillValue = newValue > 0 ? newValue : nil
            self.updateBarHeight()
            self.updateBarColor()
        }
    }

    public var realValue: String? {
        get {
            return self.miniFlareView.text
        }
        set {
            self.miniFlareView.text = newValue
            self.updateminiFlareViewAppearance()
        }
    }

    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }

    public var subtitle: String? {
        get {
            return self.subtitleLabel.text
        }
        set {
            self.subtitleLabel.text = newValue
        }
    }
}

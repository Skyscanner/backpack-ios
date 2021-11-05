/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

    /// Whether the bar is selected or not
    public override var isSelected: Bool {
        didSet {
            updateBarColor()
            updateminiFlareViewAppearance()
        }
    }

    /// The relative value of the bar between 0.0 and 1.0. This determines how "full" the bar will appear.
    public var fillValue: NSNumber? {
        didSet {
            updateBarHeight()
            updateBarColor()
        }
    }

    /// The actual value associated with the bar.
    /// This is the value shown in the flare when the bar is selected.
    public var valueDescription: String? {
        get {
            return miniFlareView.text
        }
        set {
            miniFlareView.text = newValue
            updateminiFlareViewAppearance()
        }
    }

    /// The title to show below the bar
    public var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    /// The subtitle to show below the title
    public var subtitle: String? {
        get {
            return subtitleLabel.text
        }
        set {
            subtitleLabel.text = newValue
        }
    }

    /// The absolute position of the top of the bar view
    public var barTopPosition: CGFloat {
        return barView.frame.origin.y
    }

    fileprivate var barViewHeightAnchor: NSLayoutConstraint?
    fileprivate var miniFlareViewPositionAnchor: NSLayoutConstraint?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    fileprivate func setupViews() {
        addSubview(backgroundView)
        addSubview(barView)
        addSubview(miniFlareView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalToConstant: BPKSpacingBase),
            barView.widthAnchor.constraint(equalToConstant: BPKSpacingBase),
            barView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            barView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            miniFlareView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            subtitleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: BPKSpacingMd),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: BPKSpacingMd),
            bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: BPKSpacingMd)
        ])
        updateBarHeight()
        updateminiFlareViewAppearance()
    }

    lazy fileprivate var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = BPKColor.dynamicColor(
            withLightVariant: BPKColor.skyGrayTint06,
            darkVariant: BPKColor.blackTint03
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = BPKSpacingMd
        return view
    }()

    lazy fileprivate var barView: UIView = {
        let view = UIView()
        view.backgroundColor = BPKBarChartBar.noValueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = BPKSpacingMd
        return view
    }()

    lazy fileprivate var miniFlareView: BPKMiniFlareView = {
        let view = BPKMiniFlareView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy fileprivate var titleLabel: BPKLabel = {
        let view = BPKLabel(fontStyle: .textBaseEmphasized)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy fileprivate var subtitleLabel: BPKLabel = {
        let view = BPKLabel(fontStyle: .textSm)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    static fileprivate var noValueColor: UIColor = BPKColor.skyGrayTint03
    static fileprivate var valueColor: UIColor = BPKColor.primaryColor
    static fileprivate var selectedColor: UIColor = BPKColor.dynamicColor(
        withLightVariant: BPKColor.monteverde,
        darkVariant: BPKColor.glencoe
    )

    fileprivate func updateBarColor() {
        if isSelected {
            barView.backgroundColor = BPKBarChartBar.selectedColor
            titleLabel.textColor = BPKBarChartBar.selectedColor
            subtitleLabel.textColor = BPKBarChartBar.selectedColor
            return
        }

        titleLabel.textColor = BPKColor.textPrimaryColor
        subtitleLabel.textColor = BPKColor.textPrimaryColor
        barView.backgroundColor = fillValue.map { _ in BPKBarChartBar.valueColor } ?? BPKBarChartBar.noValueColor
    }

    fileprivate func updateBarHeight() {
        if barViewHeightAnchor != nil {
            barViewHeightAnchor!.isActive = false
        }

        barViewHeightAnchor = fillValue.map {
            barView.heightAnchor.constraint(
                equalTo: backgroundView.heightAnchor,
                multiplier: CGFloat($0.doubleValue)
            )
        } ?? barView.heightAnchor.constraint(equalToConstant: BPKSpacingLg)

        assert(barViewHeightAnchor != nil, "barViewHeightAnchor should not be nil")
        barViewHeightAnchor?.isActive = true
    }

    fileprivate func updateminiFlareViewAppearance() {
        if miniFlareViewPositionAnchor != nil {
            miniFlareViewPositionAnchor?.isActive = false
        }

        miniFlareViewPositionAnchor = miniFlareView.bottomAnchor.constraint(
            equalTo: barView.topAnchor,
            constant: -BPKSpacingSm
        )

        assert(barViewHeightAnchor != nil, "miniFlareViewPositionAnchor should not be nil")
        miniFlareViewPositionAnchor?.isActive = true

        miniFlareView.isHidden = valueDescription == nil || !isSelected
    }
}

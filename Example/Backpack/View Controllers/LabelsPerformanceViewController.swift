/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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
import Backpack

class LabelsPerformanceViewController: UIViewController {
    @IBOutlet weak var verticalStackView: UIStackView!

    static let styles: [(BPKFontStyle, BPKFontStyle)] = [
        (BPKFontStyle.textXs, BPKFontStyle.textXsEmphasized),
        (BPKFontStyle.textSm, BPKFontStyle.textSmEmphasized),
        (BPKFontStyle.textBase, BPKFontStyle.textBaseEmphasized),
        (BPKFontStyle.textLg, BPKFontStyle.textLgEmphasized),
        (BPKFontStyle.textXl, BPKFontStyle.textXlEmphasized)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 0..<100 {
            let emphasized = index % 2 == 0
            let view = LabelsPerformanceViewController.buildHorizontalStackView(emphasized: emphasized)
            verticalStackView.addArrangedSubview(view)
        }
    }

    static func buildHorizontalStackView(emphasized: Bool) -> UIStackView {
        let horizontalStackView = UIStackView(frame: CGRect.zero)
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = BPKSpacingSm
        horizontalStackView.distribution = .equalSpacing

        for style in styles {
            let fontStyle = emphasized ? style.1 : style.0

            let label = Backpack.Label(fontStyle: fontStyle)
            label.text = "Backpack"
            horizontalStackView.addArrangedSubview(label)
        }

        return horizontalStackView
    }
}

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

enum LabelsDisplayType {
    case normal
    case emphasized
    case heavy
}

class LabelsViewController: UIViewController {
    @IBOutlet var labels: [Backpack.Label]!
    var type: LabelsDisplayType = .normal

    static let normalStyles: [BPKFontStyle] = [
        .textCaps, .textXs, .textSm, .textBase, .textLg, .textXl, .textXxl, .textXxxl
    ]
    static let emphasizedStyles: [BPKFontStyle] = [
        .textCapsEmphasized, .textXsEmphasized, .textSmEmphasized, .textBaseEmphasized,
        .textLgEmphasized, .textXlEmphasized, .textXxlEmphasized, .textXxxlEmphasized
    ]
    static let heavyStyles: [BPKFontStyle] = [.textXlHeavy, .textXxlHeavy, .textXxxlHeavy]

    override func viewDidLoad() {
        super.viewDidLoad()

        var styles: [BPKFontStyle]! = nil
        switch type {
        case .normal:
            styles = LabelsViewController.normalStyles
        case .emphasized:
            styles = LabelsViewController.emphasizedStyles
        case .heavy:
            styles = LabelsViewController.heavyStyles
        }
        assert(styles.count <= labels.count, "Number of styles must be less than or equal to the number of labels")

        labels[0..<(labels.count - styles.count)].forEach {
            $0.isHidden = true
        }
        zip(labels[(labels.count - styles.count)..<labels.count], styles).forEach { (tuple) in
            let (label, style) = tuple

            label.isHidden = false
            label.fontStyle = style

            if style != .textCaps && style != .textCapsEmphasized {
                label.text = "Backpack rocks!"
            } else {
                label.text = "BACKPACK ROCKS!"
            }
        }
    }
}

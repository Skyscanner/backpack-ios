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
    @IBOutlet var stack: UIStackView!

    let styles: [(BPKFontStyle, String)] = [
        (.textHero1, "Hero1"),
        (.textHero2, "Hero2"),
        (.textHero3, "Hero3"),
        (.textHero5, "Hero5"),
        (.textHero4, "Hero4"),
        (.textHeading1, "Heading1"),
        (.textHeading2, "Heading2"),
        (.textHeading3, "Heading3"),
        (.textHeading4, "Heading4"),
        (.textHeading5, "Heading5"),
        (.textSubheading, "Subheading"),
        (.textBodyLongform, "BodyLongform"),
        (.textBodyDefault, "BodyDefault"),
        (.textFootnote, "Footnote"),
        (.textCaption, "Caption"),
        (.textLabel1, "Label 1"),
        (.textLabel2, "Label 2"),
        (.textLabel3, "Label 3")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        styles.map {
            let label = BPKLabel(fontStyle: $0.0)
            label.text = $0.1
            label.numberOfLines = 0
            return label
        }.forEach(stack.addArrangedSubview)
    }
}

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

class LabelMultiFontStyleViewController: UIViewController {

    @IBOutlet weak var label: BPKLabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        label.numberOfLines = 15
        label.fontStyle = .textHeading1

        label.text = "This is a BPKLabel which supports multiple different font styles. You can simply create" +
        "a BPKLabel, and then set the FontStyle to use for any given range.\nALWAYS INK RESPONSIBLY."
        label.setFontStyle(.textHero5, range: NSRange(location: 10, length: 8))
        label.setFontStyle(.textBodyDefault, range: NSRange(location: 33, length: 32))
        label.setFontStyle(.textCaption, range: NSRange(location: 97, length: 14))
        label.setFontStyle(.textBodyLongform, range: NSRange(location: 116, length: 9))
        label.setFontStyle(.textFootnote, range: NSRange(location: 141, length: 12))
        label.setFontStyle(.textSubheading, range: NSRange(location: 154, length: 23))
    }
}

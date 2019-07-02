/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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

enum LinkCount {
    case single
    case double
}

class TappableLinkLabelsViewController: UIViewController {
    var linkCount: LinkCount = .single
    var style: BPKTappableLinkLabelStyle = .default
    var fontStyles = [
        BPKFontStyle.textCaps,
        BPKFontStyle.textSm,
        BPKFontStyle.textBase,
        BPKFontStyle.textLg,
        BPKFontStyle.textXlEmphasized,
        BPKFontStyle.textXxlEmphasized
    ]

    @IBOutlet var tappableLinks: [TappableLinkLabel]!
    @IBOutlet var displayView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(fontStyles.count == tappableLinks.count,
               "Number of font styles does not match the number of tappable links.")

        let content = "Backpack is Skyscanner's design system."
        let firstLinkContent = "Backpack"
        let secondLinkContent = "Skyscanner's"

        displayView.backgroundColor = style == .alternate ? Color.blue500 : Color.white

        let firstRange = NSRange(content.range(of: firstLinkContent)!, in: content)
        let secondRange = NSRange(content.range(of: secondLinkContent)!, in: content)

        var linkIndex = 0
        for tappableLink in tappableLinks {
            tappableLink.text = content
            tappableLink.fontStyle = fontStyles[linkIndex]
            tappableLink.style = style
            tappableLink.delegate = self
            tappableLink.numberOfLines = 2

            tappableLink.addLink(to: URL(string: "https://backpack.github.io/")!, with: firstRange)

            if linkCount == .double {
                tappableLink.addLink(to: URL(string: "https://www.skyscanner.net/")!, with: secondRange)
            }
            linkIndex += 1
        }
    }

}

extension TappableLinkLabelsViewController: BPKTappableLinkLabelDelegate {
    func attributedLabel(_ label: TappableLinkLabel, didSelectLinkWith url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

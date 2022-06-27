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

enum LinkCount {
    case single
    case double
}

enum LinkType {
    case web
    case print
}

class TappableLinkLabelsViewController: UIViewController, BPKTappableLinkLabelDelegate {
    var linkType: LinkType = .web
    var linkCount: LinkCount = .single
    var style: BPKTappableLinkLabelStyle = .default
    var textColor: UIColor?
    var fontStyles = [
        BPKFontStyle.textCaption,
        BPKFontStyle.textFootnote,
        BPKFontStyle.textBodyDefault,
        BPKFontStyle.textBodyLongform,
        BPKFontStyle.textHeading3,
        BPKFontStyle.textHeading2
    ]

    @IBOutlet var tappableLinks: [BPKTappableLinkLabel]!
    @IBOutlet var displayView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isAlternateStyleWithLightMode() {
            let titleAttributes = [NSAttributedString.Key.foregroundColor: BPKColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
            self.navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
            self.navigationController?.navigationBar.tintColor = BPKColor.white
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)

        if isAlternateStyleWithLightMode() {
            let titleAttributes = [NSAttributedString.Key.foregroundColor: BPKColor.skyGray]
            self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
            self.navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
            self.navigationController?.navigationBar.tintColor = BPKColor.skyGray
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(
            fontStyles.count == tappableLinks.count,
            "Number of font styles does not match the number of tappable links."
        )

        let content = "Backpack is Skyscanner's design system."
        let firstLinkContent = "Backpack"
        let secondLinkContent = "Skyscanner's"

        displayView.backgroundColor = style == .alternate ? BPKColor.skyBlueShade03 : BPKColor.backgroundColor

        let firstRange = NSRange(content.range(of: firstLinkContent)!, in: content)
        let secondRange = NSRange(content.range(of: secondLinkContent)!, in: content)

        var linkIndex = 0
        for tappableLink in tappableLinks {
            if let textColor = textColor {
                tappableLink.textColor = textColor
            }
            tappableLink.text = content
            tappableLink.fontStyle = fontStyles[linkIndex]
            tappableLink.style = style
            tappableLink.delegate = self
            tappableLink.numberOfLines = 3

            if linkType == .web {
                tappableLink.addLink(to: URL(string: "https://backpack.github.io/")!, with: firstRange)

                if linkCount == .double {
                    tappableLink.addLink(to: URL(string: "https://www.skyscanner.net/")!, with: secondRange)
                }
            }
            if linkType == .print {
                tappableLink.addLink(toTransitInformation: ["link text": "Backpack"], with: firstRange)

                if linkCount == .double {
                    tappableLink.addLink(toTransitInformation: ["link text": "Skyscanner's"], with: secondRange)
                }
            }
            linkIndex += 1
        }
    }

    func tappableLabel(_ label: BPKTappableLinkLabel, didSelectLinkWith url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    func tappableLabel(
        _ label: BPKTappableLinkLabel,
        didSelectLinkWithTransitInformation components: [AnyHashable: Any]
    ) {
        print(components)
    }

    func isAlternateStyleWithLightMode() -> Bool {
        #if swift(>=4.2)
        if #available(iOS 13.0, *) {
            return style == .alternate && traitCollection.userInterfaceStyle == .light
        }

        #endif
        return true
    }
}

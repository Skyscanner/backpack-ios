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
import Backpack

enum LabelsDisplayType {
    case normal
    case emphasized
    case heavy
}

class LabelsViewController: UIViewController {
    @IBOutlet weak var stack: UIStackView!
    
    var type: LabelsDisplayType = .normal
    let styles: [(BPKFontStyle, String)] = [
        (.textHeading1, "Quarantine rules: what to do after visiting a red list destination"),
        (.textSubheading, "If you need to travel to a red list country, it’s important to fully " +
    "understand the UK’s quarantine rules. Arrange your quarantine hotel package in advance a" +
    "nd remember to take a PCR test before arriving in the UK."),
        (.textBodyLongform, "The Foreign, Commonwealth & Development Office (FCDO) advises against " +
    "all but essential travel to red list destinations, and anyone travelling to the UK from a " +
    "‘high risk’ country is required to hotel quarantine. When travel to a red list country is un" +
    "avoidable, these are the quarantine rules you should follow on your return."),
        (.textHeading4, "The latest quarantine rules"),
        (.textBodyDefault, "Starting February 11, UK COVID-19 tests for vaccinated travellers are set " +
    "to be axed. The rules have also been eased for unvaccinated holidaymakers, who will no longer" +
    " have to take a day eight test or self-isolate, but will still need pre-departure and day two " +
    "tests. Learn more.\nFrom December 15, 2021, there are no countries on the UK’s red list, which " +
    "means there are currently no hotel quarantine requirements for people arriving from those countr" +
    "ies.\nWhile the red list remains in place as the “first line of defence against future variants”" +
    ", the government is seeking to replace the hotel quarantine policy with other contingency measure" +
    "s. Home isolation might be an option. Details will be revealed in spring."),
        (.textFootnote, "Things can change pretty quickly. For the latest updates on the red list destina" +
    "tions, please refer to our map or gov.uk."),
        (.textCaption, "Back to COVID-19 planning")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styles.map { (style, text) in
            let label = BPKLabel(fontStyle: style)
            label.text = text
            label.numberOfLines = 0
            return label
        }.forEach(stack.addArrangedSubview)
    }
}

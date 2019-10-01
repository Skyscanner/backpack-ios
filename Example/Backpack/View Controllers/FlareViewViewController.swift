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

class FlareViewViewController: UIViewController {
    @IBOutlet weak var flareView: FlareView!

    var showFlare: Bool = true
    var backgroundImage: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        flareView.isFlareVisible = showFlare
        flareView.backgroundColor = Color.skyBlue

        let label = Label(fontStyle: .textXlEmphasized)
        label.text = "Much wow!"
        label.textColor = Color.white
        label.translatesAutoresizingMaskIntoConstraints = false
        flareView.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: flareView.contentView.topAnchor, constant: BPKSpacingBase),
            label.leadingAnchor.constraint(equalTo: flareView.contentView.leadingAnchor, constant: BPKSpacingBase),
            flareView.contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: BPKSpacingBase)
            ])

        if backgroundImage {
            label.textColor = Color.skyGray

            let image = UIImage(named: "pilanesburg-south-africa")
            let imageView = UIImageView.init(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false

            flareView.backgroundView.addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: flareView.heightAnchor),
                imageView.widthAnchor.constraint(equalTo: flareView.widthAnchor),
                imageView.topAnchor.constraint(equalTo: flareView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: flareView.leadingAnchor),
                flareView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                flareView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
                ])
        }
    }
}

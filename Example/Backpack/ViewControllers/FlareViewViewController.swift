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
import Backpack

class FlareViewViewController: UIViewController {
    @IBOutlet weak var flareView: BPKFlareView!

    var backgroundImage: Bool = false
    var rounded: Bool = false
    var flareAtTop: Bool = false
    var animated: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        flareView.backgroundColor = BPKColor.skyBlue

        let label = BPKLabel(fontStyle: .textXlEmphasized)
        label.text = "Much wow!"
        label.textColor = BPKColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        flareView.contentView.addSubview(label)

        let flareViewCenterYConstraint = flareView.centerYAnchor.constraint(
            equalTo: self.view.centerYAnchor,
            constant: BPKSpacingNone
        )

        if animated {
            flareViewCenterYConstraint.constant = -250.0
        }

        NSLayoutConstraint.activate([
            flareViewCenterYConstraint,
            label.topAnchor.constraint(equalTo: flareView.contentView.topAnchor, constant: BPKSpacingBase),
            label.leadingAnchor.constraint(equalTo: flareView.contentView.leadingAnchor, constant: BPKSpacingBase),
            flareView.contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: BPKSpacingBase)
            ])

        if flareAtTop {
            flareView.flarePosition = .top
        }

        if backgroundImage {
            label.textColor = BPKColor.skyGray

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

        if rounded {
            flareView.cornerRadius = BPKCornerRadiusLg
        }

        if animated {
            UIView.animate(withDuration: 2.5) {
                flareViewCenterYConstraint.constant = 0.0
                self.view.layoutIfNeeded()
            }
        }

    }
}

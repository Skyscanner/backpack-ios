//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

import Foundation

final class PriceExampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.surfaceDefaultColor
        createView()
    }
    
    private func createView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = BPKSpacingBase
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        [
            ("Left and large", createPrice(alignment: .leading, size: .large)),
            ("Left and small", createPrice(alignment: .leading, size: .small)),
            ("Right and large", createPrice(alignment: .trailing, size: .large)),
            ("Right and small", createPrice(alignment: .trailing, size: .small))
        ].forEach {
            let label = BPKLabel(fontStyle: .textHeading5)
            label.text = $0.0
            
            let rowStackView = UIStackView(arrangedSubviews: [label, $0.1])
            rowStackView.axis = .horizontal
            rowStackView.distribution = .equalCentering
            
            stackView.addArrangedSubview(rowStackView)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BPKSpacingBase),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -BPKSpacingBase),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func createPrice(alignment: BPKPrice.Alignment, size: BPKPrice.Size) -> BPKPrice {
        let price = BPKPrice(
            price: "£1830",
            leadingText: "App only deal",
            lineThroughText: "£2033",
            trailingText: "per day",
            alignment: alignment,
            size: size
        )
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }
}

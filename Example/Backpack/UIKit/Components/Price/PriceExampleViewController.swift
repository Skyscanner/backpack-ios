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

import UIKit
import Backpack

final class PriceExampleViewController: UIViewController {
    
    public var size: BPKPrice.Size
    
    init(size: BPKPrice.Size) {
        self.size = size
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.canvasColor
        createView()
    }
    
    private func createView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = BPKSpacingBase
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(createRow())
        stackView.addArrangedSubview(createRow(trailingText: "per day"))
        stackView.addArrangedSubview(createRow(previousPrice: "£2033", trailingText: "per day"))
        stackView.addArrangedSubview(createRow(leadingText: "App ony deal", trailingText: "per day"))
        stackView.addArrangedSubview(createRow(
            leadingText: "App only deal",
            previousPrice: "£2033",
            trailingText: "per day")
        )
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BPKSpacingBase),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -BPKSpacingBase),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
        
    private func createRow(
        leadingText: String? = nil,
        previousPrice: String? = nil,
        trailingText: String? = nil) -> UIView {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .top
            stackView.translatesAutoresizingMaskIntoConstraints = false
        
            [BPKPrice.Alignment.leading, BPKPrice.Alignment.trailing].forEach { alignment in
                let priceView = BPKPrice(alignment: alignment, size: size)
                priceView.price = "£1830"
                priceView.leadingText = leadingText
                priceView.previousPrice = previousPrice
                priceView.trailingText = trailingText
                priceView.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(priceView)
            }
            
            return stackView
    }
}

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
import UIKit

public class BPKHotelStarRating: UIView {
    
    public var rating: Int {
        didSet {
            guard rating != oldValue else { return }
            updateLookAndFeel()
        }
    }
    
    public var size: BPKStarSize {
        didSet {
            guard size != oldValue else { return }
            updateLookAndFeel()
        }
    }
    
    private var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        
        return view
    }()
    
    public init(size: BPKStarSize = .small, rating: Int = 0) {
        self.size = size
        self.rating = rating
        super.init(frame: .zero)
        setup()
    }
    
    public override init(frame: CGRect) {
        self.size = .small
        self.rating = 0
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        self.size = .small
        self.rating = 0
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(stackView)
        updateLookAndFeel()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func updateLookAndFeel() {
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        guard rating > 0 else { return }
        
        for _ in Range(1...rating) {
            let star = BPKStar(size: size)
            star.state = .full
            stackView.addArrangedSubview(star)
        }
    }
}

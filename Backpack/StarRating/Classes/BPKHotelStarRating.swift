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

#if SWIFT_PACKAGE
import Backpack_ObjC
public typealias BPKStarType = Backpack_ObjC.BPKStar
public typealias BPKStarSizeType = Backpack_ObjC.BPKStarSize
public typealias BPKStarStateType = Backpack_ObjC.BPKStarState
#else
public typealias BPKStarType = BPKStar
public typealias BPKStarSizeType = BPKStarSize
public typealias BPKStarStateType = BPKStarState
#endif

public class BPKHotelStarRating: UIStackView {
    
    public var rating: Int {
        didSet {
            guard rating != oldValue else { return }
            updateLookAndFeel()
        }
    }
    
    public var size: BPKStarSizeType {
        didSet {
            guard size != oldValue else { return }
            updateLookAndFeel()
        }
    }
    
    public init(size: BPKStarSizeType = .small, rating: Int = 0) {
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
    
    public required init(coder: NSCoder) {
        self.size = .small
        self.rating = 0
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        updateLookAndFeel()
    }
    
    private func updateLookAndFeel() {
        arrangedSubviews.forEach { view in
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        guard rating > 0 else { return }
        
        for _ in Range(1...rating) {
            let star = BPKStarType(size: size)
            star.state = BPKStarStateType.full
            addArrangedSubview(star)
        }
    }
}

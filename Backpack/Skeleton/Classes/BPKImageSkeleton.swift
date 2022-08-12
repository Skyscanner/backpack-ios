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

import Foundation
import UIKit

public class BPKImageSkeleton: BPKSkeleton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func setupSubviews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = BPKSkeleton.bgColor
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: BPKSpacingXl * 3),
            widthAnchor.constraint(equalToConstant: BPKSpacingXl * 3),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    internal override func updateStyle() {
        self.layer.cornerRadius = cornerStyle
    }
}

extension BPKImageSkeleton {
    fileprivate var cornerStyle: CGFloat {
        switch super.style {
        case .rounded:
            return BPKCornerRadiusSm
        default:
            return 0
        }
    }
}

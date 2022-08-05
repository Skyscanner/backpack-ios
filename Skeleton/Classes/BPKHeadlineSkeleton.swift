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


public class BPKHeadlineSkeleton: BPKSkeleton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func setupSubviews() {
        self.backgroundColor = super.bgColor
        self.layer.cornerRadius = BPKCornerRadiusXs
    }
    
    internal override func updateSize() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            widthAnchor.constraint(equalToConstant: BPKSpacingXxl * 2),
        ])
    }
}

extension BPKHeadlineSkeleton {
    fileprivate var height: CGFloat {
        switch super.size {
        case .small:
            return BPKSpacingMd
        case .large:
            return BPKSpacingXl
        default:
            return BPKSpacingBase
        }
    }
}

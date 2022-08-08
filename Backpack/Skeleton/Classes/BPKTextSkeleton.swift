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

public class BPKTextSkeleton: BPKSkeleton {
    
    fileprivate let containerStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = BPKSpacingSm * 2.5
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func setupSubviews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = super.bgColor
        let textSkeletons = [6, 7, 4].map {
            createTextSkeletonView(length: $0)
        }
        textSkeletons.forEach { containerStackView.addArrangedSubview($0) }
        self.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    fileprivate func createTextSkeletonView(length: Int) -> UIView {
        let frame = CGRect(x: 0, y: 0, width: CGFloat(length) * BPKSpacingMd, height: BPKSpacingMd)
        let textSkeleton = UIView(frame: frame)
        textSkeleton.backgroundColor = .green
        textSkeleton.layer.cornerRadius = BPKCornerRadiusXs / 2.0
        return textSkeleton
    }
}

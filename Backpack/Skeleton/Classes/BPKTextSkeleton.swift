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

public class BPKTextSkeleton: UIView {
    var textRows = [UIView]()
    var width: CGFloat = BPKSpacingXxl * 5
    
    fileprivate let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .clear
        stack.spacing = BPKSpacingMd
        stack.distribution = .fillEqually
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    public convenience init(size: CGSize) {
        self.init()
        self.width = size.width
        setupSubviews()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupSubviews() {
        textRows = [createTextRow(), createTextRow(), createTextRow()]
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = BPKSkeletonConstants.backgroundColor
        
        self.addSubview(containerStackView)
        textRows.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textRows[1].widthAnchor.constraint(equalToConstant: width),
            textRows[0].widthAnchor.constraint(equalTo: textRows[1].widthAnchor, multiplier: 0.86),
            textRows[2].widthAnchor.constraint(equalTo: textRows[1].widthAnchor, multiplier: 0.57)
        ])
    }
    
    fileprivate func createTextRow() -> UIView {
        let textSkeleton = UIView()
        textSkeleton.backgroundColor = BPKSkeletonConstants.backgroundColor
        textSkeleton.layer.cornerRadius = BPKCornerRadiusXs / 2.0
        return textSkeleton
    }
}

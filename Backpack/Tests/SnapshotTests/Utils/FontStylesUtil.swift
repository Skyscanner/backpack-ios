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

import Backpack

extension Array where Element == BPKFontStyle {
    static var regularStyles: [BPKFontStyle] {
        [
            .textCaption,
            .textFootnote,
            .textLabel3,
            .textLabel2,
            .textLabel1,
            .textBodyDefault,
            .textBodyLongform,
            .textSubheading
        ]
    }
    
    static var headingStyles: [BPKFontStyle] {
        [
            .textHeading5,
            .textHeading4,
            .textHeading3,
            .textHeading2,
            .textHeading1
        ]
    }
    
    static var heroStyles: [BPKFontStyle] {
        [
            .textHero5,
            .textHero4,
            .textHero3,
            .textHero2,
            .textHero1
        ]
    }
}

// iPhone X dimensions
private let deviceFrame = CGRect(x: 0, y: 0, width: 375, height: 812)

func viewsInStack<S>(
    withStyles styles: [S],
    backgroundColor: UIColor = .clear,
    axis: NSLayoutConstraint.Axis = .vertical,
    _ viewProvider: ((S) -> UIView)
) -> UIView {
    let stack = UIStackView(frame: .zero)
    stack.axis = axis
    stack.spacing = BPKSpacingMd
    stack.alignment = .leading
    stack.translatesAutoresizingMaskIntoConstraints = false
    
    let parent = UIView(frame: .zero)
    parent.backgroundColor = backgroundColor
    parent.addSubview(stack)
    parent.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        stack.topAnchor.constraint(equalTo: parent.topAnchor),
        stack.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
        stack.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
        stack.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
    ])
    
    styles
        .map(viewProvider)
        .forEach(stack.addArrangedSubview)
    
    return parent
}

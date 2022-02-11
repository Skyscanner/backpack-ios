/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

extension Array where Element == BPKFontStyle {
    static var regularStyles: [BPKFontStyle] {
        [
            .textCaption,
            .textFootnote,
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

func viewsInStack(
    withStyles styles: [BPKFontStyle],
    _ viewProvider: ((BPKFontStyle) -> UIView)
) -> UIView {
    let stack = UIStackView(frame: deviceFrame)
    stack.axis = .vertical
    stack.distribution = .equalCentering
    let parent = UIView(frame: deviceFrame)
    parent.backgroundColor = BPKColor.skyGrayTint06
    parent.addSubview(stack)
    
    styles
        .map(viewProvider)
        .forEach(stack.addArrangedSubview)
    
    return parent
}

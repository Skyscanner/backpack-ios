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

import XCTest
import Backpack
import SnapshotTesting

class BPKButtonSnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    enum ButonTypes {
        case regular, iconLeft, iconRight, justIcon
    }
    
    enum ButonStates {
        case regular, loading, regularThemed, loadingThemed
    }
    
    private func applyTheme(to button: BPKButton) {
        button.primaryGradientStartColor = .red
        button.primaryGradientEndColor = .blue
        button.primaryContentColor = .black
        button.secondaryBorderColor = .purple
        button.secondaryContentColor = .red
        button.secondaryBackgroundColor = .cyan
        button.featuredGradientStartColor = .brown
        button.featuredGradientEndColor = .magenta
        button.featuredContentColor = .yellow
        button.destructiveBorderColor = .green
        button.destructiveContentColor = .blue
        button.destructiveBackgroundColor = .orange
        button.linkContentColor = .purple
    }
    
    private func icon(forSize size: BPKButtonSize) -> UIImage {
        let small = BPKIcon.makeSmallTemplateIcon(name:)
        let large = BPKIcon.makeLargeTemplateIcon(name:)
        return size == .large ? large(.longArrowRight) : small(.longArrowRight)
    }
    
    private func createViews(style: BPKButtonStyle) -> UIView {
        let stack = viewsInStack(withStyles: allTypes, axis: .horizontal) { type in
            
            viewsInStack(withStyles: allStates) { state in
                viewsInStack(withStyles: allSizes) { size in
                    let button = BPKButton(size: size, style: style)
                    button.isLoading = state == .loading || state == .loadingThemed
                    if type != .justIcon { button.title = "Button" }
                    if type != .regular { button.setImage(icon(forSize: size)) }
                    if type == .iconLeft { button.imagePosition = .leading }
                    if type == .iconRight { button.imagePosition = .trailing }
                    if state == .loadingThemed || state == .regularThemed {
                        applyTheme(to: button)
                    }
                    return button
                }
            }
        }
        return stack
    }
    
    private var allSizes: [BPKButtonSize] = [.default, .large]
    private var allTypes: [ButonTypes] = [.regular, .iconLeft, .iconRight, .justIcon]
    
    private var allStates: [ButonStates] = [
        .regular,
        .loading,
        .regularThemed,
        .loadingThemed
    ]
    
    func testDefaultPrimary() {
        assertSnapshot(createViews(style: .primary))
    }
    
    func testDefaultSecondary() {
        assertSnapshot(createViews(style: .secondary))
    }
    
    func testDefaultDestructive() {
        assertSnapshot(createViews(style: .destructive))
    }
    
    func testDefaultFeatured() {
        assertSnapshot(createViews(style: .featured))
    }
    
    func testDefaultLink() {
        assertSnapshot(createViews(style: .link))
    }
    
    func testDefaultPrimaryOnDark() {
        assertSnapshot(createViews(style: .primaryOnDark))
    }
    
    func testDefaultPrimaryOnLight() {
        assertSnapshot(createViews(style: .primaryOnLight))
    }
    
    func testDefaultSecondaryOnDark() {
        assertSnapshot(createViews(style: .secondaryOnDark))
    }
    
    func testDefaultLinkOnDark() {
        assertSnapshot(createViews(style: .linkOnDark))
    }
    
    func testBigButtonWithIconHasContentCentered() {
        let stack = viewsInStack(withStyles: [BPKButtonImagePosition.leading, .trailing]) { position in
            let button = BPKButton(size: .large, style: .primary)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.title = "Tap me"
            button.setImage(icon(forSize: .large))
            button.imagePosition = position
            button.widthAnchor.constraint(equalToConstant: 300).isActive = true
            return button
        }
        assertSnapshot(stack)
        
    }
}

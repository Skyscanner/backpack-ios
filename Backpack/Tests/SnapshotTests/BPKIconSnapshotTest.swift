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

import XCTest
import Backpack
import SnapshotTesting

final class BPKIconSnapshotTest: XCTestCase {
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testSmallIcon() {
        // Given
        let sut = BPKIcon.makeSmallIcon(name: .flight, color: BPKColor.coreAccentColor)
        let parentView = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: sut.size.width,
                height: sut.size.height
            )
        )
        
        parentView.image = sut
        assertSnapshot(parentView)
    }
    
    func testLargeIcon() {
        // Given
        let sut = BPKIcon.makeLargeIcon(name: .hotels, color: BPKColor.coreAccentColor)
        let parentView = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: sut.size.width,
                height: sut.size.height
            )
        )
        
        parentView.image = sut
        assertSnapshot(parentView)
    }
    
    func testAllSmallIcons() {
        // Given
        let views: [() -> UIView] = BPKIconsTestsUtils.allSmallIcons.map { icon in
            func makeView() -> UIView {
                let sut = BPKIcon.makeSmallIcon(name: icon, color: BPKColor.coreAccentColor)
                let parentView = UIImageView(
                    frame: CGRect(
                        x: 0,
                        y: 0,
                        width: sut.size.width,
                        height: sut.size.height
                    )
                )
                
                parentView.image = sut
                return parentView
            }
            
            return makeView
        }
        
        // Then
        assertSnapshot(generateGrid(iconSize: BPKIcon.concreteSizeForSmallIcon, makeIconView: views))
    }
    
    func testAllLargeIcons() {
        // Given
        let views: [() -> UIView] = BPKIconsTestsUtils.allLargeIcons.map { icon in
            func makeView() -> UIView {
                let sut = BPKIcon.makeLargeIcon(name: icon, color: BPKColor.coreAccentColor)
                let parentView = UIImageView(
                    frame: CGRect(
                        x: 0,
                        y: 0,
                        width: sut.size.width,
                        height: sut.size.height
                    )
                )
                
                parentView.image = sut
                return parentView
            }
            
            return makeView
        }
        
        // Then
        assertSnapshot(generateGrid(iconSize: BPKIcon.concreteSizeForLargeIcon, makeIconView: views))
    }

    private func generateGrid(iconSize: CGSize, makeIconView: [() -> UIView]) -> UIView {
        let iconsPerRow: CGFloat = 10
        let numberOfRows = ceil(CGFloat(makeIconView.count) / CGFloat(iconsPerRow))
        let width = iconsPerRow * iconSize.width + (iconsPerRow - 1) * BPKSpacingMd + BPKSpacingMd * 2
        let height = numberOfRows * iconSize.height + (numberOfRows - 1) * BPKSpacingMd + BPKSpacingMd * 2
        
        let iconsView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        for (index, view) in makeIconView.enumerated() {
            let row = index / Int(iconsPerRow)
            let col = index % Int(iconsPerRow)
            
            let imageView = view()
            
            let xCoordinate: CGFloat = BPKSpacingMd + CGFloat(col) * (iconSize.width + BPKSpacingMd)
            let yCoordinate: CGFloat = BPKSpacingMd + CGFloat(row) * (iconSize.height + BPKSpacingMd)
            imageView.frame = CGRect(x: xCoordinate, y: yCoordinate, width: iconSize.width, height: iconSize.height)
            
            iconsView.addSubview(imageView)
        }
        
        iconsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconsView.widthAnchor.constraint(equalToConstant: width),
            iconsView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        return iconsView
    }
}

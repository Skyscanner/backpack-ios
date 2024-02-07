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

import UIKit

public class BPKTabBarItem: UITabBarItem {
    
    private let originalImage: UIImage?
    private let originalSelectedImage: UIImage?
    
    private let dotImage: BPKTabBarDotImageDefinition?
    private let selectedDotImage: UIImage?
    
    private var isDotShown: Bool
        
    public var interfaceStyle: UIUserInterfaceStyle {
        didSet {
            updateImage()
        }
    }
    
    public init(
        title: String?,
        image: UIImage?,
        selectedImage: UIImage? = nil
    ) {
        self.originalImage = image
        self.originalSelectedImage = selectedImage
        
        self.dotImage = nil
        self.selectedDotImage = nil
        
        self.isDotShown = false
        self.interfaceStyle = .unspecified
        
        super.init()
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
    }
    
    public init(
        title: String?,
        image: UIImage?,
        selectedImage: UIImage? = nil,
        dotImage: BPKTabBarDotImageDefinition,
        selectedDotImage: UIImage?
    ) {
        self.originalImage = image
        self.originalSelectedImage = selectedImage
        
        self.dotImage = dotImage
        self.selectedDotImage = selectedDotImage
        
        self.isDotShown = false
        self.interfaceStyle = .unspecified
        
        super.init()
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateImage() {
        if isDotShown {
            guard let dotImage else {
                return assertionFailure("A dot can only be displayed when the dotDefinition is set")
            }
            
            self.image = dotImage.image(for: interfaceStyle)?.withRenderingMode(.alwaysOriginal)
            self.selectedImage = self.selectedDotImage
        } else {
            self.image = originalImage
            self.selectedImage = originalSelectedImage
        }
    }
    
    public func addDot() {
        self.isDotShown = true
        self.updateImage()
    }
    
    public func removeDot() {
        self.isDotShown = false
        self.updateImage()
    }
}

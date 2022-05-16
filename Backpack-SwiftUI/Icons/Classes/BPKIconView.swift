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

import SwiftUI
import Backpack_Common

public struct BPKIconView: View {
    @State var icon: BPKIcon
    @State var size: BPKIcon.Size
    
    public init(_ icon: BPKIcon, size: BPKIcon.Size = .small) {
        self.icon = icon
        self.size = size
    }

    public var body: some View {
        Image(icon: icon, size: size)
            .resizable()
            .renderingMode(.template)
            .flipsForRightToLeftLayoutDirection(autoMirror(icon.name))
            .frame(width: size.frame.width, height: size.frame.height)
    }
    
    private func autoMirror(_ name: String) -> Bool {
        if BPKAutoMirrorIconNames.items.firstIndex(of: name) == nil {
            return false
        }
        
        return true
    }
}

private extension BPKIcon.Size {
    var frame: CGSize {
        switch self {
        case .large:
            return .init(width: 24, height: 24)
        case .small:
            return .init(width: 16, height: 16)
        }
    }
    
    var suffix: String {
        switch self {
        case .large:
            return "lg"
        case .small:
            return "sm"
        }
    }
}


private extension Image {
    init(icon: BPKIcon, size: BPKIcon.Size = .small) {
        let iconName = "\(icon.name)-\(size.suffix)"
        self.init(iconName, bundle: BPKCommonBundle.iconsBundle)
    }
}


struct BPKIconView_Previews: PreviewProvider {
    static var previews: some View {
        BPKIconView(.account, size: .large)
    }
}

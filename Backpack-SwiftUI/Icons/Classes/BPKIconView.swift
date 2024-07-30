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
    let icon: BPKIcon
    let size: BPKIcon.Size

    public init(_ icon: BPKIcon, size: BPKIcon.Size = .small) {
        self.icon = icon
        self.size = size
    }
    
    @ScaledMetric private var scaledSmallSize: CGFloat = 16
    @ScaledMetric private var scaledLargeSize: CGFloat = 24
    
    private var smallSize: CGFloat = 16
    private var largeSize: CGFloat = 24
    
    private var dimension: CGFloat {
        switch size {
        case .small: BPKFont.enableDynamicType ? scaledSmallSize : smallSize
        case .large: BPKFont.enableDynamicType ? scaledLargeSize : largeSize
        }
    }

    public var body: some View {
        Image(icon: icon, size: size)
            .resizable()
            .renderingMode(.template)
            .flipsForRightToLeftLayoutDirection(shouldAutoMirror)
            .frame(width: dimension, height: dimension)
    }
    
    private var shouldAutoMirror: Bool {
        BPKAutoMirrorIconNames.items.contains(icon.name)
    }
}

private extension BPKIcon.Size {
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
        self.init(decorative: iconName, bundle: BPKCommonBundle.iconsBundle)
    }
}

struct BPKIconView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKIconView(.account, size: .large)
            if let icon = BPKIcon.named("account--add") {
                BPKIconView(icon)
            }
        }
    }
}

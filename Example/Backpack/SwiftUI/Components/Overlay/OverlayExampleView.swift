//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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
import Backpack_SwiftUI

private func overlayView(_ overlay: Backpack_SwiftUI.BPKOverlayType, caption: String) -> some View {
    VStack(alignment: .leading, spacing: BPKSpacingSm) {
        Image("overlay_example")
            .resizable()
            .frame(width: 110, height: 110)
            .bpkOverlay(overlay)
            .cornerRadius(BPKCornerRadiusLg)
        BPKText(caption, style: .caption)
    }
}

struct SolidOverlayExampleView: View {
    var body: some View {
        VStack(spacing: BPKSpacingBase) {
            overlayView(.solid(.low), caption: "Low")
            overlayView(.solid(.medium), caption: "Medium")
            overlayView(.solid(.high), caption: "High")
        }
    }
}

struct LinearOverlayExampleView: View {
    let direction: LinearOverlayDirection
    var body: some View {
        VStack(spacing: BPKSpacingBase) {
            BPKText("Linear - \(directionName)", style: .heading3)
            overlayView(.linear(.low, direction), caption: "Low")
            overlayView(.linear(.medium, direction), caption: "Medium")
            overlayView(.linear(.high, direction), caption: "High")
        }
    }
    
    private var directionName: String {
        "\(direction)".capitalizingFirstLetter()
    }
}

struct VignetteOverlayExampleView: View {
    var body: some View {
        overlayView(.vignette, caption: "Vignette")
    }
}

struct ForegroundOverlayExampleView: View {
    var body: some View {
        ZStack {
            Image("overlay_example")
                .resizable()
                .bpkOverlay(.linear(.high, .bottom))
                .cornerRadius(BPKCornerRadiusLg)
            VStack {
                Spacer()
                HStack {
                    BPKText("Barcelona", style: .hero5)
                        .foregroundColor(.textOnDarkColor)
                    Spacer()
                }
            }
            .padding([.leading, .bottom], .lg)
        }.padding(.base)
    }
}

struct OverlayExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ForegroundOverlayExampleView()
    }
}

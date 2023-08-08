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

public struct BPKPoiMapMarker: View {
    private let state: State
    private let icon: BPKIcon
    
    private let focusedStrokeWidth: CGFloat = 1
    
    public init(state: State, icon: BPKIcon) {
        self.state = state
        self.icon = icon
    }
    
    public var body: some View {
        if state == .focused {
            poiMarker {
                markerShapeView
                    .overlay(
                        MarkerShape()
                            .stroke(Color(state.foregroundColor), lineWidth: focusedStrokeWidth)
                    )
            }
        } else {
            poiMarker { markerShapeView }
        }
    }
    
    private func poiMarker<IconView: View>(withIcon content: () -> IconView) -> some View {
        ZStack(alignment: .top) {
            content()
            iconView
                .padding(.top, state.topPadding)
        }
        .shadow(.sm)
    }
    
    private var iconView: some View {
        BPKIconView(icon)
            .foregroundColor(state.foregroundColor)
    }
    
    private var markerShapeView: some View {
        Color(state.backgroundColor)
            .frame(width: state.markerSize.width, height: state.markerSize.height)
            .clipShape(MarkerShape())
    }
}

struct BPKPoiMapMarker_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKPoiMapMarker(state: .default, icon: .landmark)
            BPKPoiMapMarker(state: .viewed, icon: .landmark)
            BPKPoiMapMarker(state: .focused, icon: .landmark)
        }
    }
}

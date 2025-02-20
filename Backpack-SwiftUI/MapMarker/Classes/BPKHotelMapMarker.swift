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

public struct BPKHotelMapMarker: View {
    private let state: BPKHotelMapMarker.State
    
    public init(state: BPKHotelMapMarker.State) {
        self.state = state
    }
    
    public var body: some View {
        poiMarker { markerShapeView }
    }
    
    private func poiMarker<IconView: View>(withIcon content: () -> IconView) -> some View {
        ZStack(alignment: .top) {
            content()
            iconView
                .padding(.top, state.topPadding)
        }
    }
    
    private var iconView: some View {
        BPKIconView(.hotels)
            .foregroundColor(state.foregroundColor)
            .scaleEffect(0.75)
    }
    
    private var markerShapeView: some View {
        Color(state.backgroundColor)
            .frame(width: state.markerSize.width, height: state.markerSize.height)
            .clipShape(BPKPoiMapMarker.MarkerShape())
    }
}

#Preview {
    VStack {
        BPKHotelMapMarker(state: .unselected)
        BPKHotelMapMarker(state: .selected)
    }
}

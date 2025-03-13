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

import Combine
import SwiftUI

extension View {
    func onScrollEnd(in coordinateSpace: CoordinateSpace, action: @escaping (CGFloat) -> Void) -> some View {
        modifier(ScrollEndDetector(coordinateSpace: coordinateSpace, onScrollEnd: action))
    }
}

final class ScrollOffsetTracker: ObservableObject {
    private let offsetSubject = CurrentValueSubject<CGFloat, Never>(0)
    var publisher: AnyPublisher<CGFloat, Never> {
        offsetSubject.eraseToAnyPublisher()
    }

    func updateOffset(_ offset: CGFloat) {
        offsetSubject.send(offset)
    }
}

struct ScrollEndDetector: ViewModifier {
    let coordinateSpace: CoordinateSpace
    let onScrollEnd: (CGFloat) -> Void
    @StateObject private var offsetTracker = ScrollOffsetTracker()

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear.preference(key: ScrollOffsetKey.self, value: abs(geometry.frame(in: coordinateSpace).origin.y))
                }
            )
            .onPreferenceChange(ScrollOffsetKey.self, perform: offsetTracker.updateOffset)
            .onReceive(
                offsetTracker.publisher
                    .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
                    .dropFirst(),
                perform: onScrollEnd
            )
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

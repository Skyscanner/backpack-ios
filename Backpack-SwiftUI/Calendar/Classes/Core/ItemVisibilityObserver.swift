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
import Combine

// MARK: - Item Visibility Detection in Scroll View
struct ItemVisibilityPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGRect] = [:]

    static func reduce(value: inout [Int: CGRect], nextValue: () -> [Int: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

class ItemVisibilityObserver: ObservableObject {
    @Published var visibleItems: [Int] = []

    private let preferencePublisher = PassthroughSubject<[Int: CGRect], Never>()
    private var cancellables = Set<AnyCancellable>()

    private var lastEmittedVisibleItems: [Int] = []

    init(parentProxy: GeometryProxy, debounceThreshold: Int) {
        preferencePublisher
            .map { preferences in
                let parentFrame = parentProxy.frame(in: .global)
                return preferences.filter { (_, frame) in
                    frame.intersects(parentFrame)
                }.map { $0.key }
            }
            .removeDuplicates() // Ensures we don't debounce if the list hasn't changed
            .debounce(for: .milliseconds(debounceThreshold), scheduler: DispatchQueue.main)
            .sink { [weak self] newVisibleItems in
                guard let self = self else { return }

                // Emit only if there's a real change in visible items
                if self.lastEmittedVisibleItems != newVisibleItems {
                    self.visibleItems = newVisibleItems
                    self.lastEmittedVisibleItems = newVisibleItems
                }
            }
            .store(in: &cancellables)
    }

    func updatePreferences(_ preferences: [Int: CGRect]) {
        preferencePublisher.send(preferences)
    }

}

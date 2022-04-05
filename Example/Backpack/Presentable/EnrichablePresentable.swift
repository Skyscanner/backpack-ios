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

extension Presentable {
    /**
     * Add an enrichment step to the presentable.
     *
     * parameter map: The function to apply to the result before returning the view controller.
     * returns: A new Presentable containing the enrichement.
    */
    func enrich(_ map: @escaping (UIViewController) -> Void) -> Presentable {
        return EnrichedPresentable(inner: self, closure: map)
    }
}

struct EnrichedPresentable {
    let inner: Presentable
    let closure: (UIViewController) -> Void
}

extension EnrichedPresentable: Presentable {
    func makeViewController() -> UIViewController {
        let innerVc = inner.makeViewController()
        closure(innerVc)

        return innerVc
    }
}

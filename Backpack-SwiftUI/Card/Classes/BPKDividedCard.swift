/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

public struct BPKDividedCard<PrimaryContent, SecondaryContent>: View where PrimaryContent: View, SecondaryContent: View {
    private let primaryContent: PrimaryContent
    private let secondaryContent: SecondaryContent
    private var tapAction : () -> Void = {}

    public init(
        @ViewBuilder primaryContent: @escaping () -> PrimaryContent,
        @ViewBuilder secondaryContent: @escaping () -> SecondaryContent
    ) {
        self.primaryContent = primaryContent()
        self.secondaryContent = secondaryContent()
    }

    public var body: some View {
        BPKCard(padding: .none) {
            VStack(spacing: 0) {
                primaryContent
                Color(BPKColor.lineColor)
                    .frame(height: 1)
                secondaryContent
            }
            .onTapGesture {
                tapAction()
            }
        }
    }
    
    public func onTapGesture(perform: @escaping () -> Void) -> BPKDividedCard {
        var result = self
        result.tapAction = perform
        return result
    }
}

struct BPKDividedCard_Priviews: PreviewProvider {
    static var previews: some View {
        BPKDividedCard {
            let message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. " +
            "Aenean commodo ligula eget dolor. Aenean massa."
            Text(message)
                .padding()
        } secondaryContent: {
            Text("Lorem ipsum dolor sit amet")
                .padding()
        }
        .padding()
    }
}


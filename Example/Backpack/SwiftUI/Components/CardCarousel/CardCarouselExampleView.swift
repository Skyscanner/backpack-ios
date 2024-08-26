//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
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

struct CardCarouselExampleView: View {
    @State private var currentIndex: Int = 0
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        GeometryReader { reader in
            HStack(alignment: .center, spacing: .zero) {
                BPKCardCarousel(
                    cards: [
                        createCard(image: "graphic_promo"),
                        createCard(image: "Dublin-TempleBar"),
                        createCard(image: "canadian_rockies_canada")
                    ],
                    currentIndex: $currentIndex
                )
                .if( // This is to demonstrate IPad that isnt landscape
                    horizontalSizeClass == .regular && !UIDevice.current.orientation.isLandscape,
                    transform: { view in
                        view.frame(
                            width: reader.size.width * 0.8,
                            height: reader.size.height * 0.5
                        )
                    }
                )
                .if( // This is to demonstrate IPad that is landscape
                    horizontalSizeClass == .regular && UIDevice.current.orientation.isLandscape,
                    transform: { view in
                        view.frame(
                            width: reader.size.width * 0.8,
                            height: reader.size.height * 0.8
                        )
                    }
                )
                .position(
                    x: reader.size.width / 2,
                    y: reader.size.height / 2
                )
            }
        }
    }
    
    private func createCard(image: String) -> some View {
        BPKCarouselCard(
            content: {
                Image(image)
                    .resizable()
                    .scaledToFill()
            },
            title: "Someone Walking",
            description: "Look at the views",
            contentAccessibilityLabel: "Hiker hiding behind rocks"
        )
    }
}

#Preview {
    CardCarouselExampleView()
}

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

// swiftlint:disable closure_body_length
struct OnboardingView: View {
    var body: some View {
        VStack {
            BPKText("Drops", style: .heading2)
                .accessibilityLabel("Learn more about drops")
                .accessibilityAddTraits(.isHeader)
            TabView {
                BPKPanel(padding: false) {
                    VStack(alignment: .leading) {
                        Image(decorative: "carousel_placeholder_1")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                        VStack(alignment: .leading) {
                            BPKText("Page 1", style: .heading3)
                            BPKText("Loads of text we want you to read to talk about how great drops is!")
                        }
                        .padding(.base)
                    }
                }
                .accessibilityElement(children: .combine)
                .padding(.base)
                
                BPKPanel(padding: false) {
                    VStack(alignment: .leading) {
                        Image(decorative: "carousel_placeholder_1")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                        VStack(alignment: .leading) {
                            BPKText("Page 2", style: .heading3)
                            BPKText("Even more content talking about our feature")
                        }
                        .padding(.base)
                    }
                }
                .accessibilityElement(children: .combine)
                .padding(.base)
                
                BPKPanel(padding: false) {
                    VStack(alignment: .leading) {
                        Image(decorative: "carousel_placeholder_1")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                        VStack(alignment: .leading) {
                            BPKText("Welcome to drops, we're happy to have you!", style: .heading3)
                            BPKText("Loads of text we want you to read to talk about how great drops is!")
                        }
                        .padding(.base)
                    }
                }
                .accessibilityElement(children: .combine)
                .padding(.base)
                
                .padding(.base)
                
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            BPKButton("Log in for Drops", size: .large) {
                print("Log in tapped")
            }
            .stretchable()
            .padding()
        }
    }
}

#Preview {
    OnboardingView()
}

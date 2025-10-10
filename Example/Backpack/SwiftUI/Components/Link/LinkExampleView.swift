//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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
import Backpack_Common

struct LinkExampleView: View {
    @State private var showTermsSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .lg) {
                defaultLink
                onContrastLink
            }
            .padding()
        }
        .navigationTitle("Link")
        .sheet(isPresented: $showTermsSheet) {
            LinkTermsSheet()
                .presentationDetents([.medium])
        }
    }

    private var defaultLink: some View {
        Backpack_SwiftUI.BPKLink(
            markdown:
                "This is your [Terms](app://terms) and " +
                "[Privacy policy](https://www.example.com/privacy)."
        ) { url in
            if url.host == "terms" || url.path == "/terms" {
                showTermsSheet = true
            }
        }
    }

    private var onContrastLink: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Backpack_SwiftUI.BPKLink(
                markdown: "Need help? [Contact support](app://support) to start a chat.",
                style: Backpack_SwiftUI.BPKLinkStyle.onContrast
            ) { _ in
                showTermsSheet = true
            }
        }
        .padding()
        .background(Color(BPKColor.surfaceContrastColor))
        .cornerRadius(BPKCornerRadius.md.value)
    }
}

private struct LinkTermsSheet: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .md) {
            BPKText("Terms and conditions", style: .heading4)
            BPKText(
                "These terms describe how Backpack components should be used across Skyscanner apps." +
                "\n\nTap close to dismiss."
            )
        }
        .padding()
    }
}

struct LinkExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LinkExampleView()
        }
    }
}

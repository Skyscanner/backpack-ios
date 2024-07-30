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

struct BannerAlertExampleView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .md) {
                ForEach([0, 1], id: \.self) { id in
                    let style: BPKBannerAlert.Style = id == 0 ? .default : .onContrast
                    let title = id == 0 ? "Default" : "OnContrast"
                    VStack {
                        Text("\(title) Style")
                            .font(.title3)
                        infoBanner(for: style)
                        warningBanner(for: style)
                        successBanner(for: style)
                        errorBanner(for: style)
                        multilineBanner(for: style)
                    }
                    .padding(.md)
                    .background(id == 0 ? .canvasColor : .canvasContrastColor)
                }
            }
        }
    }
    
    private func infoBanner(for style: BPKBannerAlert.Style) -> some View {
        BPKBannerAlert(
            type: .info(accessibilityLabel: "Information"),
            style: style,
            message: "Info Banner"
        )
    }
    
    private func warningBanner(for style: BPKBannerAlert.Style) -> some View {
        BPKBannerAlert(
            type: .warning(accessibilityLabel: "Warning"),
            style: style,
            message: "Warning Banner"
        )
    }
    
    private func successBanner(for style: BPKBannerAlert.Style) -> some View {
        BPKBannerAlert(
            type: .error(accessibilityLabel: "Error"),
            style: style,
            message: "Error Banner"
        )
    }
    
    private func errorBanner(for style: BPKBannerAlert.Style) -> some View {
        BPKBannerAlert(
            type: .success(accessibilityLabel: "Success"),
            style: style,
            message: "Success Banner"
        )
    }
    
    private func multilineBanner(for style: BPKBannerAlert.Style) -> some View {
        BPKBannerAlert(
            type: .error(accessibilityLabel: "Error"),
            style: style,
            message: "Mutliline banner with custom icon \nThis is a new line",
            icon: (BPKIcon.accountAdd, accessibilityLabel: "Account Add Icon")
        )
    }
    
}

struct BannerAlertExampleView_Previews: PreviewProvider {
    static var previews: some View {
        BannerAlertExampleView()
    }
}

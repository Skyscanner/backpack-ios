/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

public struct BPKSwitch: View {
    public enum Size {
        case small, large
    }
    
    @Binding private var isOn: Bool
    private var size: Size
    
    public init(isOn: Binding<Bool>, size: Size = .large) {
        self._isOn = isOn
        self.size = size
    }
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            Group {}
        }.toggleStyle(ColoredToggleStyle(size: size))
        
    }
}

private extension BPKSwitch.Size {
    var cornerRadius: CGFloat {
        self == .large ? 16 : 10
    }
    
    var containerSize: CGSize {
        self == .large ? CGSize(width: 52, height: 32) : CGSize(width: 40, height: 20)
    }
    
    var thumbSize: CGFloat {
        self == .large ? 28 : 16
    }
}

struct ColoredToggleStyle: ToggleStyle {
    let size: BPKSwitch.Size
    func backgroundColor(isOn: Bool) -> Color {
        isOn ? Color(.primaryColor) : Color(.skyGrayTint05.darkVariant(.blackTint03))
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: size.cornerRadius)
                .fill(backgroundColor(isOn: configuration.isOn))
            thumb(isOn: configuration.isOn, size: size.thumbSize)
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
        .frame(width: size.containerSize.width, height: size.containerSize.height)
    }
    
    private func thumb(isOn: Bool, size: CGFloat) -> some View {
        HStack {
            if isOn {
                Spacer()
            }
            Circle()
                .frame(width: size, height: size)
                .foregroundColor(.white)
                .shadow(.sm)
                .animation(.easeOut(duration: 0.2))
                .padding(2)
            if !isOn {
                Spacer()
            }
        }
    }
}

struct BPKSwitch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                BPKSwitch(isOn: .constant(true))
                BPKSwitch(isOn: .constant(false))
                BPKSwitch(isOn: .constant(true), size: .small)
                BPKSwitch(isOn: .constant(false), size: .small)
            }
            .previewLayout(.sizeThatFits)
            HStack {
                BPKSwitch(isOn: .constant(true))
                BPKSwitch(isOn: .constant(false))
                BPKSwitch(isOn: .constant(true), size: .small)
                BPKSwitch(isOn: .constant(false), size: .small)
            }
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        }
    }
}

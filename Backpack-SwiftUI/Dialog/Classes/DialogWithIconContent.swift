//
//  IconDialogContent.swift
//  Backpack-SwiftUI-Unit-Tests
//
//  Created by Nicolas Frugoni on 09/04/2023.
//

import SwiftUI

struct DialogWithIconContent: View {
    let icon: BPKIcon
    let iconColor: BPKColor
    var textContent: DialogTextContent
    var actions: DialogActionsView
    
    var body: some View {
        VStack(spacing: 0) {
            DialogIconHeaderView(icon: icon, color: iconColor)
                .padding(.bottom, -30)
            VStack(spacing: BPKSpacing.lg.value) {
                textContent
                actions
            }
            .padding(.lg)
            .padding(.top, 12)
            .background(.surfaceDefaultColor)
            .clipShape(RoundedRectangle(cornerRadius: .md))
            .shadow(.lg)
        }
    }
}

fileprivate struct DialogIconHeaderView: View {
    let icon: BPKIcon
    let color: BPKColor
    
    var body: some View {
        ZStack {
            Color(color)
                .clipShape(Circle())
                .padding(4)
            BPKIconView(icon, size: .large)
                .foregroundColor(.textPrimaryInverseColor)
        }
        .zIndex(1)
        .frame(width: 64, height: 64)
        .background(.surfaceDefaultColor)
        .clipShape(Circle())
    }
}

struct DialogWithIconContent_Previews: PreviewProvider {
    static var previews: some View {
        DialogWithIconContent(
            icon: .trash,
            iconColor: .statusDangerSpotColor,
            textContent: DialogTextContent(
                title: "Title in here",
                text: "Description that goes two lines ideally, but sometimes it can go longer",
                contentAlignment: .center
            ),
            actions: DialogActionsView(buttons: [
                BPKDialogButton("Confirm", .featured, action: {}),
                BPKDialogButton("Skip", .secondary, action: {}),
                BPKDialogButton("More info", .link, action: {})
            ])
        )
    }
}

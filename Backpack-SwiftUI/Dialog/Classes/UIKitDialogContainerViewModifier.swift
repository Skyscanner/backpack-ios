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
import UIKit

final class WeakPresenterReference: ObservableObject {
    weak var controller: UIViewController?
}

private struct ViewControllerResolver: UIViewControllerRepresentable {
    let resolve: (UIViewController) -> Void

    func makeUIViewController(context: Context) -> ResolverViewController {
        ResolverViewController(resolve: resolve)
    }

    func updateUIViewController(_ viewController: ResolverViewController, context: Context) {
        viewController.resolve = resolve
        viewController.resolveParent()
    }
}

private final class ResolverViewController: UIViewController {
    var resolve: (UIViewController) -> Void

    init(resolve: @escaping (UIViewController) -> Void) {
        self.resolve = resolve
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        resolveParent()
    }

    func resolveParent() {
        guard let parent else { return }
        resolve(parent)
    }
}

/// View modifier that adds a dialog to the view hierarchy. It uses UIKit's UIViewController presentations
/// behind the scenes.
///
/// - Parameters:
///   - isPresented: A binding to a boolean value that determines whether the dialog is presented.
///   - dialogContent: The content of the dialog.
///   - onTouchOutside: A callback that is called when the scrim is tapped.
/// - Returns: A view with the dialog added.
struct UIKitDialogContainerViewModifier<DialogContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder let dialogContent: DialogContent
    let onTouchOutside: (() -> Void)?

    @StateObject private var presenter = WeakPresenterReference()
    @State private var controller: UIViewController?

    init(
        isPresented: Binding<Bool>,
        @ViewBuilder dialogContent: () -> DialogContent,
        onTouchOutside: (() -> Void)?,
        presentingController: UIViewController
    ) {
        self._isPresented = isPresented
        self.dialogContent = dialogContent()
        self.onTouchOutside = onTouchOutside
        let presenter = WeakPresenterReference()
        presenter.controller = presentingController
        self._presenter = StateObject(wrappedValue: presenter)
    }

    init(
        isPresented: Binding<Bool>,
        @ViewBuilder dialogContent: () -> DialogContent,
        onTouchOutside: (() -> Void)?
    ) {
        self._isPresented = isPresented
        self.dialogContent = dialogContent()
        self.onTouchOutside = onTouchOutside
        self._presenter = StateObject(wrappedValue: WeakPresenterReference())
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                ViewControllerResolver { controller in
                    presenter.controller = controller
                }
                .frame(width: 0, height: 0)
            )
            .onChange(of: isPresented) { _ in
                if isPresented {
                    showDialogWithContent {
                        ZStack {
                            Color(.scrimColor)
                                .ignoresSafeArea()
                                .onTapGesture { onTouchOutside?() }
                            HStack {
                                Spacer(minLength: .lg)
                                dialogContent
                                    .frame(maxWidth: 400)
                                Spacer(minLength: .lg)
                            }
                            // Keeps the dialog inside the window with a small margin, small enough
                            // that a dialog which fits today keeps its layout. A dialog taller than
                            // that scrolls its text and keeps its buttons in view.
                            .padding(.vertical, .md)
                        }
                    }
                } else {
                    controller?.dismiss(animated: true)
                }
            }
    }
    
    private func showDialogWithContent<Content: View>(_ content: () -> Content) {
        let controller = UIHostingController(rootView: content())
        controller.view.backgroundColor = .clear
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen

        presenter.controller?.present(controller, animated: true)
        self.controller = controller
    }
}

struct UIKitDialogContainerViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Color(.canvasColor)
            .modifier(UIKitDialogContainerViewModifier(
                isPresented: .constant(true),
                dialogContent: {
                    BPKText("This is the content of a dialog!")
                        .background(.surfaceDefaultColor)
                },
                onTouchOutside: {}
            ))
    }
}

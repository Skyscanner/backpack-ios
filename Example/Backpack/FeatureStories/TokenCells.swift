struct TokenCells {
    let navigator: PresentableNavigator
    
    private func show(presentable: Presentable) {
        navigator.present(presentable: presentable)
    }
    
    private func showChilds(for title: String, childs: [Components.Group]) {
        navigator.present(title: title, groups: childs)
    }
    
    func cells() -> [CellDataSource] {
        [
            PresentableCellDataSource(
                title: "Colors",
                storyboard: .named("Main", on: "ColorsViewController"),
                showPresentable: show(presentable:)
            ),
            GroupCellDataSource(
                title: "Gradients",
                groups: SingleGroupProvider(
                    cellDataSources: [
                        PresentableCellDataSource(
                            title: "Primary",
                            storyboard: .named("Gradients", on: "PrimaryGradientViewController"),
                            showPresentable: show(presentable:)
                        ),
                        PresentableCellDataSource(
                            title: "Baseline Scrim",
                            storyboard: .named("Gradients", on: "GradientViewController"),
                            showPresentable: show(presentable:)
                        )
                    ]).groups(),
                showChilds: { showChilds(for: "Gradients", childs: $0) }
            ),
            PresentableCellDataSource(
                title: "Spacings",
                storyboard: .named("Spacings", on: "SpacingsViewController"),
                showPresentable: show(presentable:)
            ),
            PresentableCellDataSource(
                title: "Radii",
                storyboard: .named("Radii", on: "RadiiViewController"),
                showPresentable: show(presentable:)
            ),
            PresentableCellDataSource(
                title: "Shadows",
                storyboard: .named("Shadows", on: "ShadowsViewController"),
                showPresentable: show(presentable:)
            )
        ]
    }
}

struct FlareGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        enrich: @escaping (FlareViewViewController) -> Void
    ) -> CellDataSource {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Main", on: "FlareViewViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default") { _ in },
                presentable("Flare at top") { $0.flareAtTop = true },
                presentable("Rounded") { $0.rounded = true },
                presentable("Background image") { $0.backgroundImage = true },
                presentable("Animated") { flareVC in
                    flareVC.backgroundImage = true
                    flareVC.animated = true
                }
            ]
        ).groups()
    }
}

struct ChipsGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        enrich: @escaping (ChipsViewController) -> Void
    ) -> CellDataSource {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Chips", on: "ChipsViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default") { _ in },
                presentable("With icons") { $0.icons = true },
                presentable("With background color") { $0.backgroundTint = .bpk_abisko },
                presentable("Filled") { $0.style = .filled },
                presentable("Filled with background color") { target in
                    target.style = .filled
                    target.backgroundTint = .bpk_abisko
                }
            ]
        ).groups()
    }
}

struct ToastGroupsProvider {
    let showPresentable: (Presentable) -> Void
    let toastDuration: TimeInterval
    
    private func presentable(
        _ title: String,
        enrich: @escaping (ToastViewController) -> Void
    ) -> CellDataSource {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Main", on: "ToastViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Docs") {
                    $0.type = .docs
                    $0.toastHideTime = toastDuration
                },
                presentable("Default") {
                    $0.type = .defaultToast
                    $0.toastHideTime = toastDuration
                },
                presentable("With labels only") {
                    $0.type = .onlyLabels
                    $0.toastHideTime = toastDuration
                }
            ]
        ).groups()
    }
}

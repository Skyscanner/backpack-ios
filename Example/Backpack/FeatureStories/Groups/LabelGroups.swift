struct LabelGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        on storyboardIdentifier: String
    ) -> CellDataSource {
        PresentableCellDataSource(
            title: title,
            storyboard: .named("Labels", on: storyboardIdentifier),
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default", on: "LabelsViewController"),
                presentable("Performance", on: "LabelsPerformanceViewController"),
                presentable("Multiple font styles", on: "LabelMultiFontStyleViewController")
            ]
        ).groups()
    }
}

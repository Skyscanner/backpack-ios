struct HorizontalNavigationGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        enrich: @escaping (HorizontalNavViewController) -> Void
    ) -> CellDataSource {
        PresentableCellDataSource.customEnrichable(
            title: title,
            customController: { HorizontalNavViewController() },
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default") { _ in },
                presentable("Small") { $0.small = true },
                presentable("Without underline") { $0.showBar = false },
                presentable("With icons") { $0.showIcons = true },
                presentable("Small with icons") {
                    $0.small = true
                    $0.showIcons = true
                },
                presentable("Wide") {
                    $0.small = true
                    $0.showIcons = true
                    $0.wide = true
                },
                presentable("With scroll") {
                    $0.showIcons = true
                    $0.showExtraContent = true
                },
                presentable("Custom items") {
                    $0.useCustomItems = true
                    $0.showBar = false
                },
                presentable("With notification") {
                    $0.showNotificationDot = true
                    $0.showIcons = true
                },
                presentable("With badge") { $0.useItemWithBadge = true },
                presentable("Alternate") {
                    $0.appearance = .alternate
                    $0.showBar = true
                }
            ]
        ).groups()
    }
}

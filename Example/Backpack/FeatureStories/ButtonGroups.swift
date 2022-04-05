struct ButtonGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(_ title: String, style: BPKButtonStyle) -> CellDataSource {
        func enrich(screen: BPKButtonsViewController) {
            screen.style = style
        }
        return PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Buttons", on: "ButtonsViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Primary", style: .primary),
                presentable("Secondary", style: .secondary),
                presentable("Destructive", style: .destructive),
                presentable("Featured", style: .featured),
                presentable("Link", style: .link),
                presentable("Primary On Dark", style: .primaryOnDark),
                presentable("Primary On Light", style: .primaryOnLight)
            ]
        ).groups()
    }
}

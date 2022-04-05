struct ComponentCellsProvider {
    let navigator: PresentableNavigator
    
    private func show(presentable: Presentable) {
        navigator.present(presentable: presentable)
    }
    
    private func showChilds(title: String, childs: [Components.Group]) {
        navigator.present(title: title, groups: childs)
    }
    
    func cells() -> [Components.Cell] {
        let dataSources: [CellDataSource] = [
            PresentableCellDataSource(
                title: "Badges",
                storyboard: .named("Badges", on: "BadgesViewController"),
                showPresentable: show(presentable:)
            ),
            PresentableCellDataSource(
                title: "Bar charts",
                storyboard: .named("BarCharts", on: "BarChartsViewController"),
                showPresentable: show(presentable:)
            ),
            PresentableCellDataSource(
                title: "Bottom sheet",
                storyboard: .named("BottomSheet", on: "BottomSheetViewController"),
                showPresentable: show(presentable:)
            ),
            GroupCellDataSource(
                title: "Buttons",
                groups: ButtonGroupsProvider(showPresentable: show(presentable:)).groups(),
                showChilds: { showChilds(title: "Buttons", childs: $0) }
            ),
            GroupCellDataSource(
                title: "Calendar",
                groups: CalendarGroupsProvider(showPresentable: show(presentable:)).groups(),
                showChilds: { showChilds(title: "Calendar", childs: $0) }
            ),
            GroupCellDataSource(
                title: "Cards",
                groups: CardGroupsProvider(showPresentable: show(presentable:)).groups(),
                showChilds: { showChilds(title: "Cards", childs: $0) }
            ),
            GroupCellDataSource(
                title: "Chips",
                groups: ChipsGroupsProvider(showPresentable: show(presentable:)).groups(),
                showChilds: { showChilds(title: "Chips", childs: $0) }
            ),
            GroupCellDataSource(
                title: "Flare views",
                groups: FlareGroupsProvider(showPresentable: show(presentable:)).groups(),
                showChilds: { showChilds(title: "Flare views", childs: $0) }
            ),
            GroupCellDataSource(
                title: "Dialogs",
                groups: DialogGroupsProvider(showPresentable: show(presentable:)).groups(),
                showChilds: { showChilds(title: "Dialogs", childs: $0) }
            )
        ]
        return dataSources.map(\.cell)
    }
}

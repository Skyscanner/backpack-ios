struct CalendarGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        enrich: @escaping (CalendarViewController) -> Void
    ) -> CellDataSource {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Calendar", on: "CalendarViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default") { _ in },
                presentable("With max enabled date") { $0.maxEnabledDate = true },
                presentable("Custom styles for specific dates") { $0.customStylesForDates = true },
                presentable("With prices") { $0.showPrices = true },
                presentable("With alternate background color") { $0.alternativeBackgroundColor = true },
                presentable("With preselected dates") { vController in
                    let startingDate = BPKSimpleDate(year: 2020, month: 1, day: 1)
                    vController.preselectedDates = (
                        BPKSimpleDate(year: startingDate.year, month: startingDate.month + 2, day: 12),
                        BPKSimpleDate(year: startingDate.year, month: startingDate.month + 2, day: 20)
                    )
                    vController.minDate = startingDate
                }
            ]
        ).groups()
    }
}

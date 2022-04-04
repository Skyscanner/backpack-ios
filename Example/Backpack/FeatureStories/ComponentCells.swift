struct ComponentCells {
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
                groups: ButtonGroups(showPresentable: show(presentable:)).groups(),
                showChilds: { showChilds(for: "Buttons", childs: $0) }
            ),
            GroupCellDataSource(
                title: "Calendar",
                groups: CalendarGroups(showPresentable: show(presentable:)).groups(),
                showChilds: { showChilds(for: "Calendar", childs: $0) }
            )
        ]
    }
}

struct ButtonGroups {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(_ title: String, style: BPKButtonStyle) -> DataSource {
        DataSource(title: title, style: style, showPresentable: showPresentable)
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
    
    private struct DataSource: CellDataSource {
        var title: String
        let style: BPKButtonStyle
        let showPresentable: (Presentable) -> Void
        
        private func enrich(screen: UIViewController, style: BPKButtonStyle) {
            guard let screen = screen as? BPKButtonsViewController else {
                return
            }
            screen.style = style
        }
        
        func onSelected() {
            let presentable = loadStoryboard(name: "Buttons", identifier: "ButtonsViewController")
                .enrich { enrich(screen: $0, style: style) }
            showPresentable(presentable)
        }
    }
}

struct CalendarGroups {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(_ title: String, enrich: ((CalendarViewController) -> Void)? = nil) -> DataSource {
        DataSource(title: title, enrich: enrich, showPresentable: showPresentable)
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default", enrich: nil),
                presentable("With max enabled date", enrich: { $0.maxEnabledDate = true }),
                presentable("Custom styles for specific dates", enrich: { $0.customStylesForDates = true }),
                presentable("With prices", enrich: { $0.showPrices = true }),
                presentable("With alternate background color", enrich: { $0.alternativeBackgroundColor = true }),
                presentable("With preselected dates", enrich: { vController in
                    let startingDate = BPKSimpleDate(year: 2020, month: 1, day: 1)
                    vController.preselectedDates = (
                        BPKSimpleDate(year: startingDate.year, month: startingDate.month + 2, day: 12),
                        BPKSimpleDate(year: startingDate.year, month: startingDate.month + 2, day: 20)
                    )
                    vController.minDate = startingDate
                })
            ]
        ).groups()
    }
    
    private struct DataSource: CellDataSource {
        var title: String
        let enrich: ((CalendarViewController) -> Void)?
        let showPresentable: (Presentable) -> Void
        
        func onSelected() {
            let presentable = loadStoryboard(name: "Calendar", identifier: "CalendarViewController")
                .enrich {
                    guard let enrich = enrich, let viewController = $0 as? CalendarViewController else { return }
                    enrich(viewController)
                }
            showPresentable(presentable)
        }
    }
}

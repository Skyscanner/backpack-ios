struct DialogGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        enrich: @escaping (DialogViewController) -> Void
    ) -> Components.Cell {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Main", on: "DialogViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        ).cell
    }
    
    func groups() -> [Components.Group] {
        [
            Components.Group(
                title: "Alert",
                cells: [
                    presentable("With call to action", enrich: { $0.type = .normal }),
                    presentable("Warning", enrich: { $0.type = .warning }),
                    presentable("With no title", enrich: { $0.type = .noTitle }),
                    presentable("Extreme", enrich: { $0.type = .extreme })
                ]
            ),
            Components.Group(
                title: "Bottom sheet",
                cells: [
                    presentable("Delete confirmation", enrich: { $0.type = .delete }),
                    presentable("Success", enrich: { $0.type = .confirmation }),
                    presentable("With no icon", enrich: { $0.type = .noIcon }),
                    presentable("With no icon and no title", enrich: { $0.type = .noIconNoTitle })
                ]
            ),
            Components.Group(
                title: "In-app messaging",
                cells: [
                    presentable("In-app messaging", enrich: { $0.type = .inAppMessaging })
                ]
            )
        ]
    }
}

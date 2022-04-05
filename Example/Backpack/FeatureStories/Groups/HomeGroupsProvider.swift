struct HomeGroupsProvider {
    let tokens: [Components.Cell]
    let components: [Components.Cell]
    
    func groups() -> [Components.Group] {
        [
            Components.Group(
                title: "Tokens",
                cells: tokens
            ),
            Components.Group(
                title: "Components",
                cells: components
            )
        ]
    }
}

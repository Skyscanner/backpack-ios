struct SingleGroupProvider {
    let cellDataSources: [CellDataSource]
    
    func groups() -> [Components.Group] {[
        Components.Group(
            title: "",
            cells: cellDataSources.map { dataSource in
                Components.Cell(title: dataSource.title, onSelection: dataSource.onSelected)
            }
        )
    ]}
}

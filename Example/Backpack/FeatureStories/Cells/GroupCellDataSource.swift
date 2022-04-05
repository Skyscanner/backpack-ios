struct GroupCellDataSource: CellDataSource {
    var title: String
    let groups: [Components.Group]
    let showChilds: ([Components.Group]) -> Void
    
    func onSelected() {
        showChilds(groups)
    }
}

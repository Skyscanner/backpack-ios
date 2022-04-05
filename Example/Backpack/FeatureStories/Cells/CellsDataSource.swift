struct Components {
    struct Group {
        let title: String
        let cells: [Cell]
    }
    
    struct Cell {
        let title: String
        let onSelection: () -> Void
    }
}

protocol CellDataSource {
    var title: String { get }
    func onSelected()
}

extension CellDataSource {
    var cell: Components.Cell {
        Components.Cell(title: title, onSelection: onSelected)
    }
}

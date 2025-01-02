// Data type to represent an empty cell in a calendar grid (leading or trailing)
struct EmptyCellInfo: Identifiable {
    let id = UUID()
    let cellIndex: Int
    let month: Date
}

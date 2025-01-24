/// A custom callback function that handles calendar selection.
/// It gives the flexibility to use different selection behaviour after a date is tapped by the user.
/// - Parameters:
///   - CalendarSelectionSimpleType: The type of calendar selection (range or single).
///   - Date: The date which is tapped
public typealias CalendarSelectionHandler = (CalendarSelectionSimpleType, Date) -> Void

public enum CalendarSelectionSimpleType {
    /// A range selection, where the user can select a range of dates.
    case range(CalendarRangeSelectionState?)

    /// A single selection, where the user can select a single date.
    case single(CalendarSingleSelectionState?)
}

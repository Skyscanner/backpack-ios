
public struct BottomSheetInsets {
    let full: CGFloat?
    let half: CGFloat?
    let tip: CGFloat?
    
    /// Default insets for the bottom sheet.
    public init() {
        self.init(full: nil, half: 386.0, tip: 120.0)
    }
    
    /// Use this initializer to have full control over the heights and spacing of your bottom sheet
    /// - Parameters:
    ///   - full: A top inset from the safe area
    ///   - half: A bottom inset from the safe area
    ///   - tip:  A bottom inset from the safe area
    public init(full: CGFloat?, half: CGFloat?, tip: CGFloat?) {
        self.full = full
        self.half = half
        self.tip = tip
    }
}

struct BPKShadow {
    let color: BPKColor
    let radius: CGFloat
    let offset: Offset
    
    struct Offset {
        let x: CGFloat
        let y: CGFloat
    }
    
    static let sm = BPKShadow(color: .shadowSmColor, radius: 3, offset: Offset(x: 0, y: 1))
    static let lg = BPKShadow(color: .shadowLgColor, radius: 16, offset: Offset(x: 0, y: 0))
}

extension View {
    func shadow(_ shadow: BPKShadow) -> some View {
        self.shadow(color: Color(shadow.color.value.withAlphaComponent(0.15)), radius: shadow.radius, x: shadow.offset.x, y: shadow.offset.y)
            
    }
    
    func shadow(color: BPKColor = .shadowSmColor, radius: CGFloat, x: CGFloat = 0, y: CGFloat = 0) -> some View {
        shadow(color: Color(color), radius: radius, x: x, y: y)
    }
}

public extension Color {
    init(_ shadow: BPKShadow) {
        self.init(shadow.color.value.withAlphaComponent(0.15)), radius: shadow.radius, x: shadow.offset.x, y: shadow.offset.y)
    }
}
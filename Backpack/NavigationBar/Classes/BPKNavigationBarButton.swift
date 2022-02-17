//
//  BPKNavigationBarButton.swift
//  Backpack
//
//  Created by Nicolas Frugoni on 15/02/2022.
//

@objcMembers
public class BPKNavigationBarButton: BPKButton {
    public var contentColor: UIColor = BPKColor.primaryColor {
        didSet {
            linkContentColor = contentColor
        }
    }
    
    public init() {
        super.init(frame: .zero)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setup(size: ButtonSize, style: ButtonStyle) {
        super.setup(size: .default, style: .link)
    }
    
    override func contentEdgeInset(size: ButtonSize, style: ButtonStyle) -> UIEdgeInsets {
        .zero
    }
    
    override var currentFontStyle: BPKFontStyle {
        .textHeading5
    }
}

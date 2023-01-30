import SwiftUI

public protocol CardWrappable: View {
    
}

extension BPKCard: CardWrappable { }
extension BPKDividedCard: CardWrappable { }

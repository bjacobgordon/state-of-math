public enum DecimalNumber_Base: Int, CaseIterable {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    
    public var predecessor: Self {
        switch self {
        case .ten  : return Self.nine
        case .nine : return Self.eight
        case .eight: return Self.seven
        case .seven: return Self.six
        case .six  : return Self.five
        case .five : return Self.four
        case .four : return Self.three
        case .three: return Self.two
        case .two  : return Self.one
        case .one  : return Self.zero
        default    : fatalError("Base number has no defined precedent")
        }
    }
    
    public var quantity: Quantity {
        if self == .zero { return Quantity.none }
        
        let precedingQuantity = self.predecessor.quantity
        return precedingQuantity.successor
    }
    
    public var cardinality: Int {
        self.rawValue
    }
    
    var quantityMatchesCardinality: Bool {
        self.cardinality.represents(self.quantity)
    }
}

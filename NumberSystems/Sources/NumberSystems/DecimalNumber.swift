public enum DecimalNumber_Base: Int, PositionalNumberBasable {
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
    
    public static var placeholder: Self { .zero }
    
    public var predecessor: Self {
        switch self {
        case .ten  : return .nine
        case .nine : return .eight
        case .eight: return .seven
        case .seven: return .six
        case .six  : return .five
        case .five : return .four
        case .four : return .three
        case .three: return .two
        case .two  : return .one
        case .one  : return .placeholder
        default    : Self.fatalPredecessionError()
        }
    }
    
    public var quantity: Quantity {
        if self == Self.placeholder { return Quantity.none }
        
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

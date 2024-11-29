public enum DecimalNumber_Base: Int {
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
}

extension DecimalNumber_Base: PositionalNumberBasable {
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
}

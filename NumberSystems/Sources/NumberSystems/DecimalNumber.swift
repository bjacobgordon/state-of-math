enum DecimalNumber_Base: Int, CaseIterable {
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
    
    var quantity_representation: String {
        switch self {
        case .zero : return ""
        case .one  : return "|"
        case .two  : return "||"
        case .three: return "|||"
        case .four : return "||||"
        case .five : return "|||||"
        case .six  : return "||||||"
        case .seven: return "|||||||"
        case .eight: return "||||||||"
        case .nine : return "|||||||||"
        case .ten  : return "||||||||||"
        }
    }
}

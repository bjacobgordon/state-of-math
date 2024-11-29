public protocol PositionalNumberBasable: CaseIterable {
    static var placeholder: Self { get }
    
    var predecessor: Self { get }
}

extension PositionalNumberBasable {
    public static func fatalPredecessionError() -> Never {
        fatalError("Base number has no defined precedent")
    }
    
    public var quantity: Quantity {
        if self == Self.placeholder { return Quantity.none }
        
        let precedingQuantity = self.predecessor.quantity
        return precedingQuantity.successor
    }
}

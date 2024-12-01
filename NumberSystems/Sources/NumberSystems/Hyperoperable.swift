public protocol Hyperoperable: Equatable, Operable {
    static func hyperoperateUpon(
        atLevel givenLevel: Self,
        by givenOperametrum: Self,
        on givenOperand: inout Self
    )
}

extension Hyperoperable {
    public mutating func hyperoperateUpon(
        atLevel givenLevel: Self,
        by givenOperametrum: Self
    ) {
        Self.hyperoperateUpon(
            atLevel: givenLevel,
            by: givenOperametrum,
            on: &self
        )
    }
    
    public func hyperoperatedUpon(
        atLevel givenLevel: Self,
        by givenOperametrum: Self
    ) -> Self {
        var operatum = self
        operatum.hyperoperateUpon(atLevel: givenLevel, by: givenOperametrum)
        return operatum
    }
}

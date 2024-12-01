public protocol Hyperoperable: Equatable, Operable {
    mutating func hyperoperateUpon(
        atLevel givenLevel: Self,
        by givenOperametrum: Self
    )
}

extension Hyperoperable {
    public func hyperoperatedUpon(
        atLevel givenLevel: Self,
        by givenOperametrum: Self
    ) -> Self {
        var operatum = self
        operatum.hyperoperateUpon(atLevel: givenLevel, by: givenOperametrum)
        return operatum
    }
}

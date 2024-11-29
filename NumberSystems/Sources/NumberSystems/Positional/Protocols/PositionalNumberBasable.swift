public protocol PositionalNumberBasable: CaseIterable {
}

extension PositionalNumberBasable {
    public static func fatalPredecessionError() -> Never {
        fatalError("Base number has no defined precedent")
    }
}

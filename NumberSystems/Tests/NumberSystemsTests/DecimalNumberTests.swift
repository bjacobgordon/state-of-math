import Testing
@testable import NumberSystems

extension DecimalNumber_Base {
    var quantityMatchesCardinality: Bool {
        self.cardinality.represents(self.quantity)
    }
}

@Test func testBaseDecimalNumbers() async throws {
    #expect(DecimalNumber_Base.allCases.allSatisfy { $0.quantityMatchesCardinality })
}

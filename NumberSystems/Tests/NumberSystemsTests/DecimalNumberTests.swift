import Testing
@testable import NumberSystems

@Test func testBaseDecimalNumbers() async throws {
    #expect(DecimalNumber.Base.allCases.allSatisfy { $0.quantityMatchesCardinality })
}

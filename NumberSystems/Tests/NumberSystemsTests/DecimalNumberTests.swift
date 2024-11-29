import Testing
@testable import NumberSystems

@Test func testBaseDecimalNumbers() async throws {
    #expect(DecimalNumber_Base.allCases.allSatisfy { $0.quantityMatchesCardinality })
}

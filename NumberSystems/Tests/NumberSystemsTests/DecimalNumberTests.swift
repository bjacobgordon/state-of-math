import Testing
@testable import NumberSystems

@Test func testDecimalDigits() async throws {
    #expect(DecimalNumber.Digit.allCases.allSatisfy { $0.quantityMatchesCardinality })
}

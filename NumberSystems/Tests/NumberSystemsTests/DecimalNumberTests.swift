import Testing
@testable import NumberSystems

@Test func testDecimalDigitQuantities() async throws {
    DecimalNumber.Digit.allCases.forEach {
        #expect($0.quantityMatchesCardinality)
    }
}

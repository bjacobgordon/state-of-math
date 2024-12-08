import Testing
@testable import NumberSystems

extension DecimalNumber_Base {
    var representationAlignsWithCardinality: Bool {
        self.quantity_representation.count == self.rawValue
    }
}

@Test func testBaseDecimalNumbers() async throws {
    #expect(DecimalNumber_Base.allCases.allSatisfy { $0.representationAlignsWithCardinality })
}

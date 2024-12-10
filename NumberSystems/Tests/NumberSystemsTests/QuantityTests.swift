import Testing
@testable import NumberSystems

let maybeNone              = Quantity("")
let maybeStandardSingle    = Quantity("|")
let maybeStandardMany      = Quantity("||")
let maybeProprietarySingle = Quantity("🐄")
let maybeMixed             = Quantity("|🐄")

@Test func quantityInitializationViaString() async throws {
    #expect(maybeNone              != nil)
    #expect(maybeStandardSingle    != nil)
    #expect(maybeStandardMany      != nil)
    #expect(maybeProprietarySingle == nil)
    #expect(maybeMixed             == nil)
}

@Test func identitiesOfQuantities() async throws {
    let none           = maybeNone!
    let standardSingle = maybeStandardSingle!
    let standardMany   = maybeStandardMany!
    
    let uniqueQuantities = [
        none,
        standardSingle,
        standardMany,
    ].enumerated()
    
    uniqueQuantities.forEach { (outer) in
        uniqueQuantities.forEach { (inner) in
            if (outer.offset == inner.offset) {
                #expect(outer.element == inner.element, "Quantity should equal itself.")
            } else {
                #expect(outer.element != inner.element, "Quantity should not equal its neighbors.")
            }
        }
    }
}

@Test("Conversion of decimal integers to quantities", arguments: [
    0,
    10,
    100,
    1000
])
func decimalIntegerToQuantity(_ givenCount: Int) async throws {
    let equivalentQuantity = givenCount.asQuantity
    #expect(givenCount.represents(equivalentQuantity))
}

@Test("Successor of quantities", arguments: [
    0,
    10,
    100,
    1000
])
func successorOfQuantity(_ givenCount: Int) async throws {
    let operativeQuantity = givenCount.asQuantity
    let succeededCount    = givenCount + 1
    let succeededQuantity = operativeQuantity.successor
    #expect(succeededCount.represents(succeededQuantity))
}

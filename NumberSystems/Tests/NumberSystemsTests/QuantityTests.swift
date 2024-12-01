import Testing
@testable import NumberSystems

let maybeNone              = Quantity("")
let maybeStandardSingle    = Quantity("|")
let maybeStandardMany      = Quantity("||")
let maybeProprietarySingle = Quantity("🐄")
let maybeMixed             = Quantity("|🐄")

@Test func quantityInitializationViaString() async throws {
    #expect(maybeNone                 != nil)
    #expect(maybeStandardSingle       != nil)
    #expect(maybeStandardMany         != nil)
    #expect(maybeProprietarySingle    == nil)
    #expect(maybeMixed                == nil)
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

@Test("Operatrum-agnostic charateristics of level 0 hyperoperation", arguments: [
    Quantity(""  )!,
    Quantity("|" )!,
    Quantity("||")!
])
func hyperoperationAtLevel0(_ givenOperametrum: Quantity) async throws {
    let zero = Quantity.none
    let ten  = Quantity(String(repeating: "|", count: 10))!

    let eleven =    ten.hyperoperatedUpon(atLevel: zero, by: givenOperametrum)
    let twelve = eleven.hyperoperatedUpon(atLevel: zero, by: givenOperametrum)

    #expect(11.represents(eleven))
    #expect(12.represents(twelve))
}

import Testing
@testable import NumberSystems

@Test func quantityInitializationViaString() async throws {
    let maybeNone              = Quantity("")
    let maybeStandardSingle    = Quantity("|")
    let maybeStandardMany      = Quantity("||")
    let maybeProprietarySingle = Quantity("🐄")
    let maybeMixed             = Quantity("|🐄")

    #expect(maybeNone                 != nil)
    #expect(maybeStandardSingle       != nil)
    #expect(maybeStandardMany         != nil)
    #expect(maybeProprietarySingle    == nil)
    #expect(maybeMixed                == nil)
}

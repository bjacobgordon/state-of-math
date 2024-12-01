import Testing
@testable import NumberSystems

@Test func quantityInitializationViaString() async throws {
    let empty  = Quantity("")
    let single = Quantity("|")
    let mixed  = Quantity("|🐄")
    
    #expect(empty  != nil)
    #expect(single != nil)
    #expect(mixed  == nil)
}

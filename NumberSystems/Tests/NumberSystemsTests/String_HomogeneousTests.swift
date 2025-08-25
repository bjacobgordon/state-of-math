import Testing
@testable import NumberSystems

@Test func initializationOfHomogeneousStrings() async throws {
    let invalidNonEmptyString = String.Homogeneous("|||| ||||")
    let   validNonEmptyString = String.Homogeneous("||||||||" )
    let           emptyString = String.Homogeneous(""         )
    
    #expect(invalidNonEmptyString == nil)
    #expect(  validNonEmptyString != nil)
    #expect(          emptyString != nil)
}

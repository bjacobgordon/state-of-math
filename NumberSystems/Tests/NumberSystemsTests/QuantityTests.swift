import Testing
@testable import NumberSystems

let none    = Quantity(counting: "•", in: ""                          )
let single  = Quantity(counting: "•", in: "•"                         )
let pair    = Quantity(counting: "•", in: "••"                        )
let hand    = Quantity(counting: "•", in: "•••• •"                    )
let dozen   = Quantity(counting: "•", in: "•••• •••• ••••"            )
let score   = Quantity(counting: "•", in: "•••• •••• •••• ••••   ••••")
let hundred = Quantity(counting: "•", in: """
                                           •••• •••• •••• ••••   ••••
                                           •••• •••• •••• ••••   ••••
                                           •••• •••• •••• ••••   ••••
                                           •••• •••• •••• ••••   ••••
                                          
                                           •••• •••• •••• ••••   ••••
                                          """                         )
let gross   = Quantity(counting: "•", in: """
                                           •••• •••• •••• ••••
                                           •••• •••• •••• ••••
                                           •••• •••• •••• ••••
                                           •••• •••• •••• ••••
                                          
                                           •••• •••• •••• ••••
                                           •••• •••• •••• ••••
                                           •••• •••• •••• ••••
                                           •••• •••• •••• ••••
                                          
                                           •••• •••• •••• ••••
                                          """                         )

@Test func quantityAccuracy() async throws {
    #expect(  0.represents(none    ))
    #expect(  1.represents(single  ))
    #expect(  2.represents(pair    ))
    #expect(  5.represents(hand    ))
    #expect( 12.represents(dozen   ))
    #expect( 20.represents(score   ))
    #expect(100.represents(hundred ))
    #expect(144.represents(gross   ))
}

let maybeNone              = Quantity("")
let maybeStandardSingle    = Quantity("|")
let maybeStandardMany      = Quantity("||")
let maybeProprietarySingle = Quantity("•")
let maybeMixed             = Quantity("|•")

@Test func quantityInitializationViaString() async throws {
    #expect(maybeNone              != nil)
    #expect(maybeStandardSingle    != nil)
    #expect(maybeStandardMany      != nil)
    #expect(maybeProprietarySingle == nil)
    #expect(maybeMixed             == nil)
}

@Test("Conversion of decimal integers to quantities", arguments: [
       0,
      10,
     100,
    1000,
])
func decimalIntegerToQuantity(
    _ givenCount: Int,
) async throws {
    let equivalentQuantity = givenCount.asQuantity
    #expect(givenCount.represents(equivalentQuantity))
}

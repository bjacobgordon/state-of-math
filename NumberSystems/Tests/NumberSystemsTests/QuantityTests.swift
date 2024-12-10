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

@Test func quantityComparison() async throws {
    let none           = Quantity(.init(""  )!)
    let standardSingle = Quantity(.init("|" )!)
    let standardMany   = Quantity(.init("||")!)
    
    let uniqueQuantities = [
        none,
        standardSingle,
        standardMany,
    ].enumerated()
    
    uniqueQuantities.forEach { (outer) in
        uniqueQuantities.forEach { (inner) in
            if (outer.offset == inner.offset) {
                #expect(!(outer.element <  inner.element), "Quantity should not be less than itself."   )
                #expect(  outer.element == inner.element , "Quantity should be equal to itself."        )
                #expect(!(outer.element >  inner.element), "Quantity should not be greater than itself.")
                return
            }
            
            #expect(outer.element != inner.element, "Quantity should not be equal to others.")
            
            if (outer.offset < inner.offset) {
                #expect(outer.element < inner.element, "Quantity should be less than a subsequent neighbor.")
            }
            else
            if (outer.offset > inner.offset) {
                #expect(outer.element > inner.element, "Quantity should be greater than a preceding neighbor.")
            }
        }
    }
}

@Test("Successor of quantities", arguments: [
       0,
      10,
     100,
    1000,
])
func successorOfQuantity(
    _ givenCount: Int,
) async throws {
    let operativeQuantity = givenCount.asQuantity
    let succeededCount    = givenCount + 1
    let succeededQuantity = operativeQuantity.successor
    #expect(succeededCount.represents(succeededQuantity))
}

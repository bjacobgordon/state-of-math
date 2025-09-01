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

@Test func quantityComparison() async throws {
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

@Test("Predecessor of quantities", arguments: [
       1,
      10,
     100,
    1000,
])
func predecessorOfQuantity(
    _ givenCount: Int,
) async throws {
    let operativeQuantity = givenCount.asQuantity
    let  precededCount    = givenCount - 1
    let  precededQuantity = operativeQuantity.predecessor
    #expect(precededCount.represents(precededQuantity))
}

@Test("Operandum-agnostic characteristics of level 0 hyperoperation", arguments: [
    Quantity(""  )!,
    Quantity("|" )!,
    Quantity("||")!,
])
func hyperoperationAtLevel0(
    _ givenOperandum: Quantity,
) async throws {
    let zerothLevel = 0.asQuantity
    
    let ten    = 10.asQuantity
    let eleven =    ten.hyperoperated(at: zerothLevel, on: givenOperandum)
    let twelve = eleven.hyperoperated(at: zerothLevel, on: givenOperandum)
    
    #expect(11.represents(eleven))
    #expect(12.represents(twelve))
}

@Test("Alignment of level 1 hyperoperation with addition", arguments: [
    (   1, 1),
    (  10, 2),
    ( 100, 3),
    (1000, 4),
])
func hyperoperationAtLevel1(
    _ givenAugend: Int,
    _ givenAddend: Int,
) async throws {
    let firstLevel =  1.asQuantity
    
    let computedSum = givenAugend + givenAddend
    
    let   castedOperandum   = givenAugend.asQuantity
    let   castedOperametrum = givenAddend.asQuantity
    let computedOperatum    = castedOperandum.hyperoperatedUpon(at: firstLevel, by: castedOperametrum)
    
    #expect(computedSum.represents(computedOperatum))
}

@Test("Comparison of level 2 hyperoperation to multiplication", arguments: [
    (   1, 1),
    (  10, 2),
    ( 100, 3),
    (1000, 4),
])
func hyperoperationAtLevel2(_ givenMultiplicand: Int, _ givenMultiplier: Int) async throws {
    let secondLevel = 2.asQuantity
    
    let computedProduct = givenMultiplicand * givenMultiplier
    
    let   castedOperandum   = givenMultiplicand.asQuantity
    let   castedOperametrum = givenMultiplier  .asQuantity
    let computedOperatum    = castedOperandum.hyperoperatedUpon(at: secondLevel, by: castedOperametrum)
    
    #expect(computedProduct.represents(computedOperatum))
}

@Test("Comparison of level 3 hyperoperation to exponentiation", arguments: [
    (4, 1),
    (4, 2),
    (3, 3),
    (2, 4),
    (1, 4),
])
func hyperoperationAtLevel3(
    _ givenBase    : Int,
    _ givenExponent: Int,
) async throws {
    let thirdLevel = 3.asQuantity
    
    let computedPower = givenBase ** givenExponent
    
    let   castedOperandum   = givenBase    .asQuantity
    let   castedOperametrum = givenExponent.asQuantity
    let computedOperatum    = castedOperandum.hyperoperatedUpon(at: thirdLevel, by: castedOperametrum)
    
    #expect(computedPower.represents(computedOperatum))
}

@Test func hyperoperationAtLevel4() async throws {
    let fourthLevel = 4.asQuantity
    
    let computedTetratum = (2 ** 2 ** 2 ** 2 ** 1)
    
    let   castedOperand     = 2.asQuantity
    let   castedOperametrum = 4.asQuantity
    let computedOperatum    = castedOperand.hyperoperatedUpon(at: fourthLevel, by: castedOperametrum)
    
    #expect(computedTetratum.represents(computedOperatum))
}

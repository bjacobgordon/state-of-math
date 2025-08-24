import Foundation

let tallyMark: Character = "|"

public struct Quantity: Sendable {
    fileprivate static let standardEmbodyingElement = tallyMark
    
    fileprivate var embodiment: String
    
    public init(
        counting givenUnit   : Character,
        in       givenContext: String   ,
    ) {
        let derivedProprietaryEmbodiment = givenContext.filter { $0 == givenUnit }
        
        let derivedStandardEmbodiment = derivedProprietaryEmbodiment.replacingOccurrences(
            of  : String(givenUnit                    ),
            with: String(Self.standardEmbodyingElement),
        )
        
        self.embodiment = derivedStandardEmbodiment
    }
}

extension Int {
    public func represents(
        _ givenQuantity: Quantity,
    ) -> Bool {
        self == givenQuantity.embodiment.count
    }
}

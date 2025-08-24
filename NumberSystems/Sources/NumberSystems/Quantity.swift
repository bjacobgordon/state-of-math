import Foundation

let tallyMark: Character = "|"

public struct Quantity: Sendable {
    public struct Embodiment {
        fileprivate static let standardElement = tallyMark
    }
    
    fileprivate var embodiment: String
    
    public init(
        counting givenUnit   : Character,
        in       givenContext: String   ,
    ) {
        let derivedProprietaryEmbodiment = givenContext.filter { $0 == givenUnit }
        
        let derivedStandardEmbodiment = derivedProprietaryEmbodiment.replacingOccurrences(
            of  : String(givenUnit                      ),
            with: String(Self.Embodiment.standardElement),
        )
        
        self.embodiment = derivedStandardEmbodiment
    }
    
    public init(
        _ givenEmbodiment: String.Homogeneous,
    ) {
        let standardEmbodiment = givenEmbodiment.consisting(of: Self.Embodiment.standardElement)
        
        self.init(
            counting:    Self.Embodiment.standardElement,
            in      : standardEmbodiment.value          ,
        )
    }
}

extension Int {
    public func represents(
        _ givenQuantity: Quantity,
    ) -> Bool {
        self == givenQuantity.embodiment.count
    }
}

extension String {
    fileprivate var hasProprietaryElements: Bool {
        self.contains { $0 != Quantity.Embodiment.standardElement }
    }
}

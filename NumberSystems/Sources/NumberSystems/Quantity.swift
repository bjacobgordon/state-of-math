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
    
    public init?(
        _ givenEmbodiment: String,
    ) {
        if givenEmbodiment.hasProprietaryElements { return nil }
        
        self.init(
            counting: Self.standardEmbodyingElement,
            in      :         givenEmbodiment      ,
        )
    }
}

extension Int {
    public func represents(
        _ givenQuantity: Quantity,
    ) -> Bool {
        self == givenQuantity.embodiment.count
    }
    
    fileprivate var standardEmbodiment: String {
        guard 0 <= self else { fatalError("Cannot initiate Quantity instance from negative value") }
        
        return String(
            repeating: Quantity.standardEmbodyingElement,
            count    : self                             ,
        )
    }
    
    public var asQuantity: Quantity {
        let newEmbodiment = self.standardEmbodiment
        return Quantity(newEmbodiment)!
    }
}

extension String {
    fileprivate var hasProprietaryElements: Bool {
        self.contains { $0 != Quantity.standardEmbodyingElement }
    }
}

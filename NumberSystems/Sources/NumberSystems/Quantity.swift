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

extension Quantity: Comparable {
    private func compared(to another: Self) -> ComparisonResult {
        self.embodiment.cardinalityCompare(another.embodiment)
    }
    
    public static func < (
         leftHandOperand: Self,
        rightHandOperand: Self,
    ) -> Bool {
        let operandComparison = leftHandOperand.compared(to: rightHandOperand)
        return (operandComparison == .orderedAscending)
    }
    
    public static func == (
         leftHandOperand: Self,
        rightHandOperand: Self,
    ) -> Bool {
        let operandComparison = leftHandOperand.compared(to: rightHandOperand)
        return (operandComparison == .orderedSame)
    }
}

extension Int {
    public func represents(
        _ givenQuantity: Quantity,
    ) -> Bool {
        self == givenQuantity.embodiment.count
    }
    
    fileprivate var standardEmbodiment: String.Homogeneous {
        guard (0 <= self) else {
            fatalError("Cannot initiate Quantity instance from negative value")
        }
        
        let rawEmbodiment = String(
            repeating: Quantity.Embodiment.standardElement,
            count    : self                               ,
        )
        
        return .init(rawEmbodiment)!
    }
    
    public var asQuantity: Quantity {
        let newEmbodiment = self.standardEmbodiment
        return Quantity(newEmbodiment)
    }
}

extension String {
    fileprivate var hasProprietaryElements: Bool {
        self.contains { $0 != Quantity.Embodiment.standardElement }
    }
}

extension String {
    private func ends(
        beyond givenIndex: String.Index,
    ) -> Bool {
        givenIndex < self.endIndex
    }
    
    fileprivate func cardinalityCompare(
        _ that: String,
    ) -> ComparisonResult {
        let this = self
        
        var intermediateIndex = (
            forThis: this.startIndex,
            forThat: that.startIndex
        )
        
        while (true) {
            let thisKeepsGoing = this.ends(beyond: intermediateIndex.forThis)
            let thatKeepsGoing = that.ends(beyond: intermediateIndex.forThat)
            
            switch (thisKeepsGoing, thatKeepsGoing) {
            case   (          true,         false): return .orderedDescending
            case   (         false,         false): return .orderedSame
            case   (         false,          true): return .orderedAscending
            case   (          true,          true):
                intermediateIndex.forThis = this.index(after: intermediateIndex.forThis)
                intermediateIndex.forThat = that.index(after: intermediateIndex.forThat)
            }
        }
    }
}

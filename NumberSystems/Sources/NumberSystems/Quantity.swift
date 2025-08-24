import Foundation

let tallyMark: Character = "|"

public struct Quantity: Sendable {
    fileprivate static let standardEmbodyingElement = tallyMark
    private static let             embodimentOfNone = ""
    
    public static let none = Self(Self.embodimentOfNone)!
    
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

extension Quantity: Operable {
    public mutating func succeed() {
        let newElement = self.embodiment.first ?? Quantity.standardEmbodyingElement
        self.embodiment.append(newElement)
    }
    
    public mutating func precede() {
        guard (self != Quantity.none) else { fatalError("There is no precedent for a lack of quantity") }
        
        self.embodiment.removeLast()
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

let tallyMark: Character = "|"

public struct Quantity: Sendable {
    fileprivate static let standardEmbodyingElement = tallyMark
    private static let         embodimentOfNone = ""
    
    public static let none = Self(Self.embodimentOfNone)!
    
    fileprivate var embodiment: String
    
    public init?(_ givenEmbodiment: String) {
        if givenEmbodiment.hasProprietaryElements { return nil }

        self.embodiment = givenEmbodiment
    }
    
    private mutating func succede() {
        let newElement = self.embodiment.first ?? Quantity.standardEmbodyingElement
        self.embodiment.append(newElement)
    }
    
    public var successor: Self {
        var clone = self
        clone.succede()
        return clone
    }
}

extension String {
    fileprivate var hasProprietaryElements: Bool {
        self.contains { $0 != Quantity.standardEmbodyingElement }
    }
}

extension Int {
    public func represents(_ givenQuantity: Quantity) -> Bool {
        self == givenQuantity.embodiment.count
    }
}

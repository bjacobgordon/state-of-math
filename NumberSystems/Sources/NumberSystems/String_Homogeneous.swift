extension String {
    public func allCharactersAre(
        _ givenCharacter: Character,
    ) -> Bool {
        self.allSatisfy { $0 == givenCharacter }
    }
    
    public struct Homogeneous: Sendable {
        public static func test(
            _ givenString: String,
        ) -> Bool {
            guard let firstCharacter = givenString.first else {
                return true
            }
            
            return givenString.allCharactersAre(firstCharacter)
        }
        
        public let value: String
        
        public init?(
            _ givenString: String,
        ) {
            guard Self.test(givenString) else {
                return nil
            }
            
            self.value = String(givenString)
        }
        
        public func consisting(
            of givenCharacter: Character,
        ) -> Self {
            let newValue = String(
                repeating: givenCharacter,
                count    : value.count,
            )
            
            return .init(newValue)!
        }
    }
}

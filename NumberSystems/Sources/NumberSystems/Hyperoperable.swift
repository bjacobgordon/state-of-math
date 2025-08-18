public protocol Hyperoperable: Equatable, Operable {
    static func hyperoperate(
        at   givenLevel      :       Self,
        by runningOperametrum: inout Self,
        on   givenOperandum  :       Self,
    ) -> Void
}

extension Hyperoperable {
    public static func fromHyperoperating(
        at givenLevel      : Self,
        by givenOperametrum: Self,
        on givenOperandum  : Self,
    ) -> Self {
        var clonedOperametrum = givenOperametrum
        
        Self.hyperoperate(
            at:   givenLevel      ,
            by: &clonedOperametrum,
            on:   givenOperandum  ,
        )
        
        return clonedOperametrum
    }
    
    public func hyperoperatedUpon(
        at givenLevel      : Self,
        by givenOperametrum: Self,
    ) -> Self {
        let computedOperatum = Self.fromHyperoperating(
            at: givenLevel      ,
            by: givenOperametrum,
            on:      self       ,
        )
        
        return computedOperatum
    }
    
    public func hyperoperated(
        at givenLevel    : Self,
        on givenOperandum: Self,
    ) -> Self {
        let computedOperatum = Self.fromHyperoperating(
            at: givenLevel    ,
            by:      self     ,
            on: givenOperandum,
        )
        
        return computedOperatum
    }
}

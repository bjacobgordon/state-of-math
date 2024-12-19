import Foundation

extension Int: Exponentiable {
    public static func ** (
        _ base    : Int,
        _ exponent: Int,
    ) -> Int {
        let computedPower = pow(
            base    .asDouble,
            exponent.asDouble,
        )
        
        return computedPower.asInt
    }
}

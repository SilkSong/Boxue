import UIKit

enum Shape {
    case rectangle
    case circle(Double)
    case triangle
}

extension Shape: CaseIterable {
    public typealias AllCases = [Shape]
    
    public static var allCases: AllCases {
        return [Shape.rectangle, Shape.circle(1.0), Shape.triangle]
    }
}
Shape.allCases

extension Optional: CaseIterable where Wrapped: CaseIterable {
    public typealias AllCases = [Wrapped?]
    public static var allCases: AllCases {
        return Wrapped.allCases.map { $0 } + [nil]
    }
}

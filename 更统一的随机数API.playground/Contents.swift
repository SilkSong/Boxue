import UIKit

let a = Double.random(in: 0...1)
UInt8.random(in: 1..<255)
Int.random(in: Int.min...Int.max)

func coin(count: Int) -> Void {
    var result = (head: 0, back: 0)
    for _ in 1...count {
        if Bool.random() {
            result.head += 1
        } else {
            result.back += 1
        }
    }
    
    print("Head: \(result.head) Back: \(result.back)")
}

coin(count: 10000)

var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
let random = numbers.randomElement()!
let shuffled = numbers.shuffled()

enum Shape: CaseIterable {
    case rectangle
    case circle
    case triangle
    
    static func random() -> Shape {
        return self.allCases.randomElement()!
    }
    
//    static func random<T: RandomNumberGenerator>(using generator: inout T) -> Shape {
//        return allCases.randomElement(using: &generator)!
//    }
//
//    static func random() -> Shape {
//        return random(&random.default)
//    }
}

let randomShape = Shape.random() // How to implement this?


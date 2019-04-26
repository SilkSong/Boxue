import UIKit

func mul(m: Int, of n: Int) -> Int {
    return m * n
}

let fnMul = mul


func square(n: Int) -> Int {
    return n * n
}

let squareExpression = { (n: Int) -> Int in
    return n * n
}

let numbers = [1, 2, 3, 4, 5]

numbers.map { $0 * $0 }

(0...9).map { _ in arc4random() }

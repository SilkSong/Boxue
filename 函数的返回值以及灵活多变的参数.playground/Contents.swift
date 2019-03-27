import UIKit

func mul(result: inout Int, _ numbers: Int ...) {
    result = numbers.reduce(1, *) // !!! Error here !!!
    print("mul: \(result)")
}

var result = 0
mul(result: &result, 2, 3, 4, 5, 6, 7)
result

func mul2(m: Int, of n: Int) -> Int {
    return m * n
}

let fnMul = mul2
func div(a: Int, b: Int) -> Int {
    return a/b
}


(0...9).map { _ in arc4random()}

func makeCounter() -> () -> Int {
    var value = 0
    
    return {
        value += 1
        
        return value
    }
}

let counter1 = makeCounter()
let counter2 = makeCounter()

(0...2).forEach { _ in print(counter1()) } // 1 2 3
(0...5).forEach { _ in print(counter2()) }

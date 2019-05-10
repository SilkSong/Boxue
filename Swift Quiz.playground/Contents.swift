import UIKit

//2019.5.8 
func counter() -> (Int) -> String {
    var total = 0
    func add(_ x: Int) -> String {
        total += x
        return "\(total)"
    }
    return add
}

let f = counter()
f(3)

let g = counter()
g(2)

f(4)

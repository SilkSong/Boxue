
import UIKit

let a = [1, 2, 3]

a.forEach { print($0)}

let oneIndex = a.index { $0 == 1}
oneIndex

let fibonacci = [0, 1, 1, 2, 3, 5]
let constSqueares = fibonacci.map { $0 * $0 }
fibonacci
constSqueares

extension Array {
    func myMap(
}

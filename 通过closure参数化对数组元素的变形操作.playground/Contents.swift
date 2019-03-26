import UIKit

var str = "Hello, playground"

var fibonacci = [0, 1, 1, 2, 3, 5]

extension Array {
    func myMap<T>(_ transform: (Element) -> T) -> [T] {
        var temp = [T]()
        temp.reserveCapacity(count)
        
        for item in self {
            temp.append(transform(item))
        }
        return temp
    }
}

extension Array {
    func accumulate<T>( _ initial: T, nextSum: (T, Element) -> T) -> [T]{
        var sum = initial
        return map { next in
            sum = nextSum(sum, next)
            return sum
        }
    }
}

fibonacci.myMap { $0 * $0 }

fibonacci.reduce(0, +)
fibonacci

let pivot = fibonacci.partition(by: { $0 < 1 })
print(pivot)
fibonacci[0 ..< pivot]


fibonacci
extension Array {
    func myFilter(_ predicate: (Element) -> Bool) -> [Element] {
        var tmp: [Element] = []
        for value in self where predicate(value) {
            tmp.append(value)
        }
        return tmp
    }
}

extension Array {
    func myFilter1(_ predicate: (Element) -> Bool) -> [Element] {
        var tmp: [Element] = []
        
        for value in self where predicate(value) {
            tmp.append(value)
        }
        
        return tmp
    }
}

fibonacci.myFilter1 { $0 % 2 == 0 }

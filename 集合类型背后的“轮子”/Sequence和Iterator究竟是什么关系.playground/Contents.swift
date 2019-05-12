import UIKit

//protocol Sequence {
//    associatedtype Iterator: IteratorProtocol
//    func makeIterator() -> Iterator
//}

//protocol IteratorProtocal {
//    associatedtype Element
//    mutating func next() -> Element?
//}

struct FiboIterator: IteratorProtocol {
    var state = (0,1)
    mutating func next() -> Int? {
        let nextValue = state.0
        state = (state.1, state.0 + state.1)
        return nextValue
    }
}

struct Fibonacci: Sequence {
    func makeIterator() -> FiboIterator {
        return FiboIterator()
    }
}

var fib = Fibonacci()
var fibIter = fib.makeIterator()

var i = 1

//while let value = fibIter.next(), i != 10 {
//    print(value)
//    i += 1
//}

let fibo1 = Fibonacci().prefix(10).suffix(5).dropFirst(2)

for x in fibo1 {
    print(x)
}

let fiboArray = fibo1.split(whereSeparator: { $0 % 2 == 0 })
print(fiboArray)

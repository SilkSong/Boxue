import UIKit

//protocol IteratorProtocol {
//    associatedtype Element
//    mutating func next() -> Element?
//}

struct Ones: IteratorProtocol {
    mutating func next() -> Int? {
        return 1
    }
}

var ones = Ones()

ones.next() // Optional(1)
ones.next() // Optional(1)
ones.next() // Optional(1)

//struct Fibonacci: IteratorProtocol {
//    private var state = (0, 1)
//
//    mutating func next() -> Int? {
//        let nextNumber = state.0
//        self.state = (state.1, state.0 + state.1)
//
//        return nextNumber
//    }
//}


//protocol Sequence {
//    associatedtype Element
//    associatedtype Iterator: IteratorProtocol
//        where Iterator.Element == Element
//
//     func makeIterator() -> Iterator
//}

struct Fibonacci: Sequence {
    typealias Element = Int
    func makeIterator() -> FiboIter {
        return FiboIter()
    }
}

struct FiboIter: IteratorProtocol {
    var state = (0, 1)
    
    mutating func next() -> Int? {
        let nextNumber = state.0
        self.state = (state.1, state.0 + state.1)
        
        return nextNumber
    }
}

var fibs = Fibonacci()
var fib1 = fibs.makeIterator()
fib1.next() // Optional(0)
fib1.next() // Optional(1)
fib1.next() // Optional(1)
fib1.next() // Optional(2)

var fib2 = fib1

fib1.next() // Optional(3)
fib1.next() // Optional(5)
fib2.next() // Optional(3)
fib2.next() // Optional(5)

var fib3 = AnyIterator(fib2)
var fib4 = fib3

fib3.next()
fib3.next()
fib4.next()
fib4.next()

for n in Fibonacci() {
    if n <= 5 {
        print(n)
    } else {
        break
    }
}


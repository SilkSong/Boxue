import UIKit

protocol IteratorProtocol {
    associatedtype Element
    mutating func next() -> Element?
}

struct Ones: IteratorProtocol {
    mutating func next() -> Int? {
        return 1
    }
}

var ones = Ones()

ones.next() // Optional(1)
ones.next() // Optional(1)
ones.next() // Optional(1)

struct Fibonacci: IteratorProtocol {
    private var state = (0, 1)
    
    mutating func next() -> Int? {
        let nextNumber = state.0
        self.state = (state.1, state.0 + state.1)
        
        return nextNumber
    }
}

var fibs = Fibonacci()

fibs.next() // Optional(0)
fibs.next() // Optional(1)
fibs.next() // Optional(1)
fibs.next() // Optional(2)

protocol Sequence {
    associatedtype Element
    associatedtype Iterator: IteratorProtocol
        where Iterator.Element == Element
    
     func makeIterator() -> Iterator
}

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

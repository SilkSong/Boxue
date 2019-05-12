import UIKit

protocol Sequence {
    associatedtype Iterator: IteratorProtocol
    func makeIterator() -> Iterator
}

protocol IteratorProtocol {
    associatedtype Element
    mutating func next() -> Element?
}

//struct FiboIterator: IteratorProtocol {
//    var state = (0,1)
//    mutating func next() -> Int? {
//        let nextValue = state.0
//        state = (state.1, state.0 + state.1)
//        return nextValue
//    }
//}

func fiboIterator() -> AnyIterator<Int> {
    var state = (0,1)
    return AnyIterator {
        let theNext = state.0
        state = (state.1, state.0 + state.1)
        return theNext
    }
}

//struct Fibonacci: Sequence {
//    typealias Element = Int
//    func makeIterator() -> AnyIterator<Element> {
//        return AnyIterator(FiboIterator())
//    }
//}

let fiboSequence = AnySequence(fiboIterator)
print(Array(fiboSequence.prefix(10)))
//let fib = Fibonacci()
//var fibIter = fib.makeIterator()
//var i = 1
//
//while let value = fibIter.next(), i != 10 {
//    print(value)
//    i += 1
//}

let tenToOne = sequence(first: 10, next: {
    guard $0 != 1 else {
        return nil
    }
    return $0 - 1
})

print(Array(tenToOne))

let fiboSequence2 = sequence(state: (0,1), next: {
    (state: inout (Int, Int)) -> Int? in
    let theNext = state.0
    state = (state.1, state.0 + state.1)
    
    return theNext
})

print(Array(fiboSequence2.prefix(10)))


let stdIn = AnySequence {
    return AnyIterator {
        readLine()
    }
}

for i in stdIn {
    print(i)
}

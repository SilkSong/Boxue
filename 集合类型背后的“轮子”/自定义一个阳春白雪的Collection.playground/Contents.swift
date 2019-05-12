import UIKit

protocol Queue {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
}

struct FIFOQueue<Element>: Queue {
    fileprivate var storage: [Element] = []
    fileprivate var operation: [Element] = []
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    mutating func pop() -> Element? {
        if operation.isEmpty {
            operation = storage.reversed()
            storage.removeAll()
        }
        return operation.popLast()
    }
}

extension FIFOQueue: Collection {
    public var startIndex: Int { return 0 }
    public var endIndex: Int {
        return operation.count + storage.count
    }

    public func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }

    public subscript(pos: Int) -> Element {
        precondition((startIndex..<endIndex).contains(pos), "Out of range")

        if pos < operation.endIndex {
            return operation[operation.count - 1 - pos]
        }

        return storage[pos - operation.count]
    }
}

//var numberQueue = FIFOQueue<Int>()
//
//for i in 1...10 {
//    numberQueue.push(i)
//}
//
//for i in numberQueue {
//    print(i)
//}
//
//var numberArray = Array<Int>()
//numberArray.append(contentsOf: numberQueue)



extension FIFOQueue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        print(type(of: elements))
        self.init(storage: [], operation: elements.reversed())
    }
}

var numberQueue: FIFOQueue = [1, 2, 3, 4, 5]
print(numberQueue)
for i in numberQueue {
    print(i)
}


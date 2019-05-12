import UIKit

enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}

extension List {
    func insert(_ value: Element) -> List {
        return .node(value, next: self)
    }
}

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) {
            $0.insert($1)
        }
    }
}

extension List {
    mutating func push(_ value: Element) {
        self = self.insert(value)
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .end:
            return nil
        case let .node(value, next: node):
            self = node
            return value
        }
    }
}

extension List: IteratorProtocol {
    mutating func next() -> Element? {
        return pop()
    }
}

let list1: List = [1, 2, 3, 4, 5]
// 1 2 3 4 5
for i in list1 {
    print(i)
}

// 1 2 3 4 5
list1.forEach { print($0) }

// true
list1.contains(1)
// true
list1.elementsEqual([1, 2, 3, 4, 5])




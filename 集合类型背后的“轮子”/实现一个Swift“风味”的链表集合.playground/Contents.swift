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

let list1 = List<Int>.end.insert(2).insert(1)
print(list1)

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) {
            $0.insert($1)
        }
    }
}

var list2: List = [1, 2]
print(list2)

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

var list3 = list2
var list4 = list2
list2.pop()
list2.pop()

list3.pop()
list3.push(11)

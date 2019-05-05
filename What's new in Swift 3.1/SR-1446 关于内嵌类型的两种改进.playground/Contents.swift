import UIKit

class List<T> {
    class Node: CustomStringConvertible{
        var value: T
        var next: Node?
        
        init(value: T, next: Node?) {
            self.value = value
            self.next = next
        }
        
        var description: String {
            var nextText = "End"
            
            if let next = self.next {
                nextText = String(describing: next.value)
            }
            
            return "[value: \(self.value) next: \(nextText)]"
        }
    }
    
    class Storage<U> {
        var head: U? = nil
        var current: U? = nil
    }
    
    var storage: Storage<Node> = Storage()
    var count = 0
    
    func push(element: T) {
        let node = Node(value: element, next: nil)
        
        if storage.head == nil {
            storage.head = node
        }
        
        if storage.current != nil {
            storage.current?.next = node
        }
        
        storage.current = node
        count += 1
    }
}

extension List: CustomStringConvertible {
    var description: String {
        var description = ""
        var position = storage.head
        
        while position != nil {
            description += (position!.description + "\n")
            
            position = position!.next
        }
        return description
    }
}

var l: List<Int> = List<Int>()

l.push(element: 2)
l.push(element: 4)
l.push(element: 6)
l.push(element: 8)

print(l)


import UIKit

let numbers: NSMutableArray = [1, 2, 3, 4, 5]

//var numberIter = numbers.makeIterator()
//while let number = numberIter.next() {
//    numbers.removeLastObject()
//}

//for _ in numbers { // Will CRASH when iterating
//    numbers.removeLastObject()
//}

let arrayNumbers: Array = [1, 2, 3, 4, 5]

//for _ in numbers {
//    arrayNumbers.removeLast()
//}

class Queue {
    var position = 0
    var array: [Int] = []
    
    init(_ array: [Int]) {
        self.array = array
    }
    
    func next() -> Int? {
        guard position < array.count else {
            return nil
        }
        position += 1
        return array[position - 1]
    }
}

func traverseQueue(_ queue: Queue) {
    while let item = queue.next() {
        print(item)
    }
}

let q = Queue([1, 2, 3, 4, 5])
traverseQueue(q)

//for _ in 0..<1000 {
//    let q = Queue([1, 2, 3, 4, 5])
//
//    DispatchQueue.global().async {
//        traverseQueue(q)
//    }
//
//    traverseQueue(q)
//}

enum Direction: Int {
    case east
    case south
    case west
    case north
}
let east = Direction.north.rawValue
print(east)

enum Month {
    case january, february, march, april,
    may, june, july, august, september, october, noverber, december
}

let JAN = Month.january
type(of: JAN)



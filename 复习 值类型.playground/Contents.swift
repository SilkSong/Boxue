import UIKit

var numbers = [1, 2, 3, 4, 5]

for _ in numbers {
    // Compile time ERROR
    numbers.removeLast()
}

struct Point {
    var x: Double
    var y: Double
    
//    init(x: Double = 0.0, y: Double = 0.0) {
//        self.x = x
//        self.y = y
//    }
    
    init(_ pt: (Double, Double)) {
        self.x = pt.0
        self.y = pt.1
    }
    
    static let origin = Point((0,0))

}

print(Point.origin)

var numbers1 = [1, 2, 3, 4, 5]

type(of: MemoryLayout.size(ofValue: numbers1))

final class Box<T> {
    var unbox: T
    
    init(_ unbox: T) {
        self.unbox = unbox
    }
}

struct MyArray {
    var data: Box<NSMutableArray>
    var dataCOW: NSMutableArray {
        mutating get {
            if !isKnownUniquelyReferenced(&data) {
                data = Box(data.unbox.mutableCopy() as! NSMutableArray)
            }
                return data.unbox
        }

    }
    
    init(data: NSMutableArray) {
        self.data = Box(data.mutableCopy() as! NSMutableArray)
    }
}

extension MyArray {
    mutating func append(_ element: Any) {
        dataCOW.insert(element, at: self.data.unbox.count)
    }
}

var m = MyArray(data: [1, 2, 3])
let n = m

m.append(11)
let a = m.data
m.data === n.data



import UIKit

var numbers1 = [1, 2, 3, 4, 5]

MemoryLayout.size(ofValue: numbers1)

//COW 实现

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
                print("copied")
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

//var m = MyArray(data: [1, 2, 3])
//let n = m
//
//m.append(11)
//m.data === n.data

var array: [MyArray] = [MyArray(data: [1, 2, 3])]
array[0].append(4)

var item0 = array[0]
item0.append(4)

var dictionary = ["key": MyArray(data: [1, 2, 3])]

dictionary["key"]?.append(4) 



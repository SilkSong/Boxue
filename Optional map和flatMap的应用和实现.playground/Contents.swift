import UIKit

let swift: String? = "swift"
//var SWIFT: String? = nil
//
//SWIFT = swift?.uppercased()


//SWIFT 若是一个常量

let SWIFT = swift.map { $0.uppercased() }

//自己对 Optional 的 map 进行实现

extension Optional {
    func myMap<T>(_ transform: (Wrapped) -> T) -> T? {
        if let value = self {
            return transform(value)
        }
        return nil
    }
}

// Optional.flatMap 的实现（ 基于 if let)

extension Optional {
    func myFlatMap<T>(_ transform: (Wrapped) -> T?) -> T? {
        if let value = self, let mapped = transform(value) {
            return mapped
        }
        return nil
    }
}


let numbers = [1, 2, 3, 4]
//let sum = numbers.reduce(0, + )
extension Array {
    func reduce(_ nextResult: (Element, Element) -> Element) -> Element? {
//        guard let first = first else {
//            return nil
//        }
//
//        return dropFirst().reduce(first, nextResult)
        return first.map { dropFirst().reduce($0, nextResult) }
    }
}

let sum = numbers.reduce(+)

//遍历一个包含 Optional 的集合

let ints = ["1", "2", "3", "4", "five"]

//把 Ints 中的元素转换为 Int 然后求和

var all = 0

for case let int? in ints.map({ Int($0) }) {
    all += int
}

all

print(ints.compactMap { Int($0) }.reduce(0, +))

let episodes = [
    "The fail of sentinal values": 100,
    "Common optional operation": 150,
    "Nested optionals": 180,
    "Map and flatMap": 220,
]

episodes.keys
    .filter { episodes[$0]! > 100 }
    .sorted()

episodes.filter { (_, duration) in duration > 100 }
    .map { (title, _) in title }
    .sorted()


infix operator !!
infix operator !?

func !!<T>(optional: T?, errorMsg: @autoclosure () -> String) -> T {
    if let value = optional { return value }
    fatalError(errorMsg())
}



//func !?<T: ExpressibleByStringLiteral>(optional: T?, nilDefault: @autoclosure () -> (errorMsg: String, value: T)) -> T {
//    assert(optional != nil, nilDefault().errorMsg)
//    return optional ?? nilDefault().value
//
//}
//
var record = ["name": "11"]
//record["type"] !? ("Do not have a key named type", "Free"）

func !?<T: ExpressibleByStringLiteral>(
    optional: T?,
    nilDefault: @autoclosure () -> (errorMsg: String, value: T)) -> T {
    
    assert(optional != nil, nilDefault().errorMsg)
    return optional ?? nilDefault().value
}

func !?(optional: Void?, errorMsg: @autoclosure () -> String) {
    assert(optional != nil, errorMsg())
}

//record["type"]?
//    .write(" account")
//    !? "Do not have a key named type"

//record["type"] !? ("Do not have a key named type", "Free")

var eleven: Int! = 11
type(of: eleven)

var doubleValue = 4
func double(_ i: inout Int) {
    i = i * 2
}

double(&eleven)

eleven





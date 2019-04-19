import UIKit

var a: Int?
var b: Int! = 3

type(of: a)
type(of: b)

var e: [Int?] = []
typealias sum = (Int?, Int?) -> Int?

func sumFn(_ m: Int!, _ n: Int!) -> Int! {
    return m + n
}

var x: Int!
let y = x

func id<T>(_ value: T) -> T { return value }
type(of: id(x))

func forcedResult() -> Int! { return x }
//print(type(of: forcedResult()))

func apply<T>(_ fn: () -> T) -> T { return fn() }

class A: NSObject { }

class C {
    @objc var n: A! = A()
}

func getProperty(object: AnyObject) {
    print(type(of: object.n))
    if let n: A = object.n {
        print(type(of: n))
    }
}

getProperty(object: C())

func fn() throws -> Int! {
    return 11
}

if let value: Int = try? fn() {
    let n: Int = value
}


func switchDemo(_ input: String!) -> String {
    switch input {
    case let output?:
        return output
    default:
        return "nil"
    }
}




enum Seasons: String {
    case spring = "Spring", summer = "Summer", autumn = "Autumn", winter = "Winter"
}

enum SeasonType {
    case equinox
    case solstice
}

//let seasons = [Seasons.spring, .summer, .autumn, .winter]
//for (index, season) in seasons.enumerated() {
//    let seasonType = index % 2 == 0 ? SeasonType.equinox : .solstice
//    print("\(season.rawValue) \(seasonType).")
//
//}
//
//let credentials: (usermame: String?, password: String?) = ("Cosmin", nil)


class Demo {
    @objc var name: String?
    @objc dynamic var address: String?
    
    @objc func myPrint() {
        print("Demo")
    }
}

var count: UInt32 = 0
let demo = Demo()
let list = class_copyPropertyList(object_getClass(demo), &count)

for idx in 0..<numericCast(count) {
    if let item = list?[idx],
        let name = String(utf8String: property_getName(item)) {
        
        print("Property: \(name)")
    }

}

var fCount: UInt32 = 0
let funcList = class_copyMethodList(object_getClass(demo), &fCount)
for idx in 0..<numericCast(fCount) {
    if let item = funcList?[idx] {
        let name = NSStringFromSelector(method_getName(item))
        print("Method: \(name)")
    }
}

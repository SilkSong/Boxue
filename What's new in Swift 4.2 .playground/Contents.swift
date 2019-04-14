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



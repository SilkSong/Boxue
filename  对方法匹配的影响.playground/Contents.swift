import UIKit

class A: NSObject { }

class C {
    @objc var n: A! = A()
}

let values: [Any]! = [C()]
let transformed = values?.map { $0 as! C }

let intValues: [Int]! = [1]
let transformedInts = intValues.map { $0 + 1 }

func fn(_: Int?) {}

let iuoElement: A! = nil
let array: [Any] = [iuoElement as Any]
let nsArray = array as NSArray

let element = nsArray[0]
if element is NSNull {
    print("Nil value")
} else {
    print("Non nil value")
}

var result = true
result.toggle()

import UIKit

let s = "Hello Mars"
var i = s.firstIndex(of: " ")!

//In Swift 3

var greeting = s.prefix(upTo: i)
var greetingWithSpace = s.prefix(through: i)
var Mars = s.suffix(from: s.index(i, offsetBy: 1))

//In Swift 4
greeting = s[..<i]
greetingWithSpace = s[...i]
Mars = s[i...]

//更方便的表达无穷序列
for (n, v) in s.enumerated() {
    print("\(n) \(v)")
}

print(Array(zip(1..., s)))
print(Array(zip(s, 1...)))

//更方便的pattern matching

let n = 10

switch n {
case 6...:
    print(">= 6")
default:
    break
}

//String should be a Collection again

let hello = "Hello Mars"
hello.count

let spaceIndex = hello.firstIndex(of: " ")!
let subString = hello[..<spaceIndex]

hello.forEach { print($0)}

//SE-0168 Multi-Line String Literals
let xmlInfo = """
<?xml version="1.0"?>
<episode id="1">
<title>String is a collection again</title>
<author>11</author>
<created_at>2017-05-18</created_at>
</episode>
"""

let jsonInfo = """
{
"episode": {
"title": "String is a collection",
"author": "11",
"created_at": "2017-05-18"
}
}
"""
print(xmlInfo)
print(jsonInfo)

//更智能安全的Key Value Coding

class Foo: NSObject {
    @objc var bar = "BAR"
    @objc var baz = [1, 2, 3, 4]
}

var foo = Foo()

//In olde swift
var bar = foo.value(forKeyPath: #keyPath(Foo.bar))
foo.setValue("BaR", forKeyPath: #keyPath(Foo.bar))
foo.bar

//In Swift 4
let barKeyPath = \Foo.bar
var newBar = foo[keyPath: barKeyPath]
foo[keyPath: barKeyPath] = "baR"

let bazKeyPath = \Foo.baz

//Dictionary初始化以及常用操作的诸多改进

let numberSet = Set(1...100)
let subSet = Set(1...50)
let evens = numberSet.lazy.filter { $0 % 2 == 0 }
type(of: evens)

//Error
//evens.isSubset(of: numberSet)

let numberDictionary =
    ["one": 1, "two": 2, "three": 3, "four": 4]
let evenColl =
    numberDictionary.lazy.filter { $0.1 % 2 == 0 }

let evenDictionary = Dictionary(uniqueKeysWithValues: evenColl.map { (key: $0.0, value: $0.1)})
evenDictionary

let numbers = ["ONE", "TWO", "THREE"]

for (n, v) in numbers.enumerated() {
    print("\(n) \(v)")
}
var numbersDict = Dictionary(uniqueKeysWithValues:
    numbers.enumerated().map { ($0.0 + 1, $0.1) })
numbersDict

let cc = zip(1..., numbers)

numbersDict = Dictionary(uniqueKeysWithValues: cc)
print(numbersDict)

let duplicates = [("a", 1), ("b", 2), ("a", 3), ("b", 4)]

let letters = Dictionary(duplicates, uniquingKeysWith: { (first, _) in first })
print(letters)

//组织序列中满足特定条件的元素
let names = ["Aaron", "Abe", "Bain", "Bally", "Bald", "Mars", "Nacci"]
let groupedNames = Dictionary(grouping: names, by: { $0.first!})
print(groupedNames)

//带有默认值的下标操作符

let characters = "aaabbbcc"
var frequencies: [Character: Int] = [:]

//characters.forEach {
//    if frequencies[$0] != nil {
//        frequencies[$0]! += 1
//    } else {
//        frequencies[$0] = 1
//    }
//}
//
//frequencies

characters.forEach {
    frequencies[$0, default: 0] += 1
}

frequencies

//转为Dictionary定制的filter和mapValue
print(numberDictionary)
let filtered = numberDictionary.filter { $0.value % 2 == 0 }
print(filtered)

let mapped = numberDictionary.mapValues { $0 + 1}
print(mapped)

let map = numberDictionary.map { $1 }
print(map)

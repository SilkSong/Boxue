import UIKit


var fiveInts = [1, 2, 3, 4, 5]

func getBufferAddress<T>(of array: [T]) -> String {
    return array.withUnsafeBufferPointer { buffer in
        return String(describing: buffer.baseAddress)
    }
}

fiveInts.removeLast()
fiveInts.popLast()

var fibonacci = [0, 1, 1, 2, 3, 5]

var cc = [0, 1, 2, 4, 7, 12]

print(fibonacci.map { $0 * $0 })

extension Array {
    func myMap<T>(_ transform: (Element) -> T) -> [T] {
        var tmp:[T] = []
        tmp.reserveCapacity(count)
        for value in self {
            tmp.append(transform(value))
        }
        return tmp
    }
}

print(fibonacci.myMap { $0 * $0 })

//let pivot = fibonacci.partition(by: { $0 < 1 })
//fibonacci[0 ..< pivot] // [5, 1，1，2, 3]
//
//fibonacci[pivot ..< fibonacci.endIndex] // [0]

var sum = 0
let constSquares2 = fibonacci.map { (fib: Int) -> Int in
    sum += fib
    return fib * fib
}

sum

constSquares2

extension Array {
    func accumulate<T>(_ initial: T,
                       _ nextSum: (T, Element) -> T) -> [T] {
        var sum = initial
        
        return map { next in
            sum = nextSum(sum, next)
            return sum
        }
    }
}


[1,2,3].accumulate(0, +)

print(fibonacci.filter { $0 % 2 == 0 })

extension Array {
    func myFilter(_ predicate: (Element) -> Bool) -> [Element] {
        var tmp:[Element] = []
        for value in self where predicate(value) {
            tmp.append(value)
        }
        return tmp
    }
}

print(fibonacci.myFilter { $0 % 2 == 0 })


extension Array {
    func myReduc<T>(_ initial: (T), _ next:(T, Element) -> T) -> T {
        var tmp = initial
        for value in self {
            tmp = next(tmp, value)
        }
        return tmp
    }
}

fibonacci.myReduc(0, +)

let str = fibonacci.myReduc("") { str, num in
    return str + "\(num)"
}


str
extension Array {
    func myMap2<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([], { $0 + [transform($1)] })
    }

    func myFilter2(_ predicate: (Element) -> Bool) -> [Element] {
        return reduce([], { predicate($1) ? [$1] : $0 })

    }
}

print(fibonacci.myMap2 { $0 * $0 })
print(fibonacci.myFilter2 { $0 % 2 == 0})


enum RecordType {
    case bool(Bool)
    case number(Int)
    case text(String)
}

let defaultRecord: [String: RecordType] = [
    "uid": .number(0),
    "exp": .number(100),
    "favourite": .bool(false),
    "title": .text("")
]

var template = defaultRecord
var record11Patch: [String: RecordType] = [
    "uid": .number(11),
    "title": .text("Common dictionary extensions")
]

// How can we do this?
// template.merge(record11Patch)
// [
//    uid: .number(11),
//    "exp": .number(100),
//    "favourite": .bool(false),
//    "title": .text("Common dictionary extensions")
// ]

extension Dictionary {
    mutating func merge<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
        sequence.forEach { self[$0] = $1 }
    }
}

 template.merge(record11Patch)

let record11: [String: RecordType] = [
    "uid": .number(11),
    "title": .text("Common dictionary extensions")
 ]


struct Account {
    var alias: String
    var type: Int
    var createdAt: Date
}

let account11 = Account(alias: "11",
                        type: 1, createdAt  : Date())


extension Account: Hashable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.alias == rhs.alias &&
            lhs.type == rhs.type &&
            lhs.createdAt == rhs.createdAt
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(alias)
        hasher.combine(createdAt)
        hasher.combine(type)
    }
}

let data:[Account: Int] = [ account11: 1000 ]

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var result: Set<Iterator.Element> = []
        
        return filter {
            if result.contains($0) {
                return false
            } else {
                result.insert($0)
                return true
            }
        }
    }
}

[1, 1, 2, 2, 3, 3, 4, 4].unique() // [1, 2, 3, 4]
let hw = "Hello world!"

// CharacterSet
let numbers = CharacterSet(charactersIn: "123456789")
let letters = CharacterSet.letters

// Actions
hw.rangeOfCharacter(from: numbers) // nil
print(hw.rangeOfCharacter(from: letters)) //

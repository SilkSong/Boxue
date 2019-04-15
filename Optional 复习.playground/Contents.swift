import UIKit


let numbers = [1, 2, 3, 4, 5, 6]
var iterator = numbers.makeIterator()

while let element = iterator.next() {
    print(element)
}


for i in numbers {
    print(i)
}


let a: Int? = 1
let b = a ?? 2

let stringOnes: [String] = ["1", "One"]
let intOnes = stringOnes.map { Int($0) }

intOnes.forEach { print($0) }

let swift: String? = "swift"


let SWIFT = swift.map { $0.uppercased() }


extension Optional {
    func myMap<T>(_ transform: (Wrapped) -> T) -> T? {
        if let value = self {
            return transform(value)
        }
        return nil
    }
}

extension Optional {
    func myFlatMap<T>(_ transform: (Wrapped) -> T?) -> T? {
        if let value = self,
            let mapped = transform(value) {
            return mapped
        }
        return nil
    }
}

let stringOne: String? = "1"
let oo = stringOne.flatMap { Int($0) }

let ints = ["1", "2", "3", "4", "five"]

print(ints.map { Int($0) })

var all = 0

for case let int? in ints.map({ Int($0) }) {
    all += int
}

let ALL = ints.flatMap { Int($0) }.reduce(0, +)
ALL

let AAA = ints.flatMap { Int($0) }
print(AAA)

let episodes = [
    "The fail of sentinal values": 100,
    "Common optional operation": 150,
    "Nested optionals": 180,
    "Map and flatMap": 220,
]

print(episodes.keys.filter { episodes[$0]! > 100 })

var eleven: Int! = 11

if eleven == 11 {
    print(eleven)
}

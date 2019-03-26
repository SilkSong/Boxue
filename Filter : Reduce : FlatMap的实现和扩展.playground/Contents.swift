import UIKit

var fibonacci = [0, 1, 1, 2, 3, 5]

//复习
//Map 的实现

print(fibonacci.map { $0 * 2 })

extension Array {
    func myMap<T>(_ transform: (Element) -> T) -> [T] {
        var tmp:[T] = []
        for value in self {
            tmp.append(transform(value))
        }
        return tmp
    }
}
print(fibonacci.myMap { $0 * 2 })


//Filter 的实现

print(fibonacci.filter { $0 < 3 })

extension Array {
    func myFilter(_ predicate: (Element) -> Bool) -> [Element] {
        var tmp: [Element] = []
//        for value in self {
//            if predicate(value) {
//                tmp.append(value)
//            }
//        }
        for value in self where predicate(value) {
            tmp.append(value)
        }
        return tmp
    }
}

print(fibonacci.myFilter { $0 < 3 })

//Reduce 的实现

print(fibonacci.reduce(0, +))

extension Array {
    func myReduce<T>(_ initial: T, _ next: (T, Element) -> T) -> T {
        var tmp = initial
        for value in self {
            tmp = next(tmp, value)
        }
        return tmp
    }
}

print(fibonacci.reduce(0, +))

//用 Reduce 实现 Map

extension Array {
    func myMap2<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([], { $0 + [transform($1)] })
    }
}

print(fibonacci.myMap2 { $0 * 2 })

//用 Reduce 实现 Filter

extension Array {
    func myFilter2(_ predicate: (Element) -> Bool) -> [Element] {
        return reduce([], { predicate($1) ? $0 + [$1] : $0 })
    }
}

print(fibonacci.myFilter2 { $0 < 3 })

//FlatMap

let animals = ["🐶", "🐱", "🐻", "🐯"]
let ids = [1, 2, 3, 4]

print(animals.flatMap { animal in
    ids.map { id in (animal, id)}
})

//FlatMap 的实现

extension Array {
    func myFlatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var tmp: [T] = []
        for value in self {
            tmp.append(contentsOf: transform(value))
        }
        return tmp
    }
}

print(animals.myFlatMap { animal in
    ids.map { id in (animal, id)}
})

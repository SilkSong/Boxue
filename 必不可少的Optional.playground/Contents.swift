import UIKit

enum Optional<T> {
    case some(T)
    case none
}

extension Array where Element: Equatable {
    func find(_ element: Element) -> Index? {
        var index = startIndex
        while index != endIndex {
            if self[index] == element {
                return index
            }
            
            formIndex(after: &index)
        }
        return nil
    }
}

var numbers = [1, 2, 3]
let index = numbers.find(4)

print(type(of: index))

let array = [1, 2, 3, 4, 5]
var iterator = array.makeIterator()

while let value = iterator.next() {
    print(value)
}

for value in array {
    print(value)
}

var fnArray: [() -> ()] = []

for i in 0...2 {
    fnArray.append { print(i) }

}


func toDo(item: String?) -> Never {
    guard let item = item else {
        fatalError("Nothing to do")
    }
    
    fatalError("Implement \(item) later")
}

let dic = ["fibo6": [0, 1, 1, 2, 3, 5]]
dic["fibo6"]?[0]

//双层嵌套

let stringOnes: [String] = ["1", "One"]
let intOnes = stringOnes.map { Int($0) }
type(of: intOnes)
intOnes.forEach { print($0) }

for case let one? in intOnes {
    print(one)
}




import UIKit

let names = ["Paula", "Elena", "Zoe"]

print(Array(names.reversed()))

var lastNameEndingInA: String?
for name in names.reversed() where name.hasSuffix("a") {
    lastNameEndingInA = name
    break
}
lastNameEndingInA

extension Sequence {
    func last(_ predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in self where predicate(element) {
            return element
        }
            return nil
    
    }
}
//extension Sequence {
//    func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
//        for element in reversed() where predicate(element) {
//            return element
//        }
//        return nil
//    }
//}

print(names.last { name in name.hasSuffix("a") } )

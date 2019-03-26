import UIKit

//利用 Set 特性为序列去重

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

//利用 Reduce 实现

let array = [1, 1, 2, 2, 3, 4, 5, 5]

array.reduce([], { $0 == [$1] ? $0 : $0 + [$1] } )

array.unique()

var setA: Set = [1, 2, 3, 4, 5, 6]
var setB: Set = [4, 5, 6, 7, 8, 9]

// [4,5,6]
let interSectAB: Set = setA.intersection(setB)
//[1,2,3,7,8,9]
let symmetricDiffAB: Set = setA.symmetricDifference(setB)
//[1,2,3,4,5,6,7,8,9]
let unionAB: Set = setA.union(setB)
//[1,2,3]
let aSubstractB: Set = setA.subtracting(setB)


let hw = "Hello world!"

// CharacterSet
let numbers = CharacterSet(charactersIn: "123456789")
let letters = CharacterSet.letters

print(letters)

// Actions
hw.rangeOfCharacter(from: numbers) // nil
hw.rangeOfCharacter(from: letters)


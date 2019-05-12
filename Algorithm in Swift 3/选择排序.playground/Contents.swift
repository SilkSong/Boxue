import UIKit

typealias Criteria<T> = (T, T) -> Bool
func SelectionSortOf<T: Comparable>(_ coll: Array<T>, byCriteria: Criteria<T> = {$0 > $1 }) -> Array<T> {
    guard coll.count > 1 else {
        return coll
    }
//    var sorted: Array<T> = []
//    var unSorted = coll
//    for x in 0..<coll.count {
//        var candidate =
//        var maxIndex = unSorted.firstIndex(of: max!)
//        unSorted.swapAt(0, maxIndex!)
//
//        sorted.append(max!)
//        unSorted.removeFirst()
//        //print(unSorted)
//    }
//    return sorted
    var result = coll
    for x in 0 ..< coll.count - 1 {
        var candidateIndex = x
        print("--------------------------")
        print("Sorted:\t\(result[0 ..< candidateIndex])")
        print("Unsorted:\t\(result[candidateIndex ..< result.count])")
        
        for y in x + 1 ..< coll.count {
            if byCriteria(result[y], result[candidateIndex]) {
                candidateIndex = y
            }
        }
        print(">>> Move \(result[candidateIndex]) into the sorted portion")
        if (candidateIndex != x) {
            result.swapAt(candidateIndex, x)
        }
    }
    return result
}

//let array = [5,1,7,6]
//let sorted = SelectionSortOf(array)
//print(sorted)


let a: Array<Int> = [1, 5, 7, 6]
SelectionSortOf(a, byCriteria: <)
print(a)

//let a = [1, 5, 7, 6]
//
//func SelectionSortOf<T: Comparable>(_ coll: Array<T>, byCriteria: Criteria<T> = {$0 > $1 }) -> T {
//    var result = coll
//
//    for x in 0 ..< coll.count - 1 {
//        var candicate = x
//        for y in x + 1 ..< coll.count {
//            if byCriteria(result[y], result[candicate]) {
//                candicate = y
//            }
//        }
//    }
//
//}



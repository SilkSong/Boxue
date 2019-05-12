import UIKit

typealias CRITERIA<T> = (T, T) -> Bool
func insertionSortOf<T: Comparable>(_ coll: Array<T>, byCriteria: CRITERIA<T> = { $0 < $1 }) -> Array<T> {
    guard coll.count > 1 else {
        return coll
    }
    //复制一份参数数组，用于在函数内部进行排序
    var result = coll

    for x in 1..<result.count {
        var y = x
        var key = result[y]
        
        print("Get: \(key)")
        
        while y > 0 && byCriteria(key, result[y-1]) {
            print("-----------------------------")
            print("Remove: \(result[y]) at pos: \(y)")
            print("Insert: \(key) at pos: \(y - 1)")
            print("-----------------------------")
            
//            result.remove(at: y)
//            result.insert(key, at: y-1)
            result.swapAt(y, y-1)
            
            y -= 1
        }
    }
    
    return result
}

let a: Array<Int> = [1, 5, 6]
//insertionSortOf(a)
insertionSortOf(a, byCriteria: >)

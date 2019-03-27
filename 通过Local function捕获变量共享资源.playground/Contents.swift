import UIKit

extension Array where Element: Comparable {
    mutating func mergeSort(_ begin: Index, _ end: Index) {
        
        var tmp: [Element] = []
        tmp.reserveCapacity(count)
        
        func merge(_ begin: Index, _ mid: Index, _ end: Index) {
            tmp.removeAll(keepingCapacity: true)
            
            var i = begin
            var j = mid
            
            while i != mid && j != end {
                if self[i] < self[j] {
                    tmp.append(self[i])
                    i += 1
                } else {
                    tmp.append(self[j])
                    j += 1
                }
            }
            
            //        print(self[i ..< mid])
            //        print("空格")
            //        print(self[j ..< end])
            
            tmp.append(contentsOf: self[i ..< mid])
            tmp.append(contentsOf: self[j ..< end])
            
            replaceSubrange(begin ..< end, with: tmp)
        }
        
        if (end - begin) > 1 {
            let mid = (begin + end) / 2
            
            mergeSort(begin, mid)
            mergeSort(mid, end)
            
            merge(begin, mid, end)
        }
    }
    

}

var numbers = [1, 2, 6, 9, 8]
numbers.mergeSort(numbers.startIndex, numbers.endIndex)

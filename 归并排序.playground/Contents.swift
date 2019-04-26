import UIKit

extension Array where Element: Comparable {
    mutating func mergeSort(_ begin: Index, _ end: Index) {
        
        //A shared storage across all recrisive calls
        var tmp: [Element] = []
        tmp.reserveCapacity(count)
        
        func merge(_ begin: Index, _ mid: Index, _ end: Index) {

            //1. Use the same shared storage
            tmp.removeAll(keepingCapacity: true)
            
            //2. Fetch the smaller one from the two piles
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
            
            //3. Append the remaining
            tmp.append(contentsOf: self[i ..< mid])
            tmp.append(contentsOf: self[j ..< end])
            
            //4. Update self
            replaceSubrange(begin..<end, with: tmp)
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


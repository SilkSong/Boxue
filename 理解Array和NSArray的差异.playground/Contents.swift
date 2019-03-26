import UIKit

var arrayA = [1,2,3]
let copyA = arrayA

arrayA.append(0)

let b = NSMutableArray(array: [1,2,3])
let copyB: NSArray = b
let deepCopyB = b.copy() as! NSArray

func getBufferAddress<T>(of array: [T]) -> String {
    return array.withUnsafeBufferPointer { buffer in
        return String(describing: buffer.baseAddress)
    }
}

b.insert(0, at: 0)
copyB
deepCopyB
getBufferAddress(of: arrayA)
getBufferAddress(of: copyA)




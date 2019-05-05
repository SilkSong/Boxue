import UIKit

func increaseValue(in array: [Int], with: @autoclosure () -> Int) {
    func increaseValueTmp(in array: [Int], with: () -> Int) {
        withoutActuallyEscaping(with) { escapedWith in
            let increasedArray = array.lazy.map { $0 + escapedWith() }
            
            print(increasedArray[0])
            print(increasedArray[1])
        }
    }
    
    increaseValueTmp(in: array, with: with)
}


let array = [1,1,1]
increaseValue(in: array, with: 2 )

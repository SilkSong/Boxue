import UIKit

let serialQueue = DispatchQueue(label: "serial")

let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)

//for i in 0..<10 {
//    serialQueue.sync {
//        print(i)
//        print(Thread.current)
//    }
//}


//for i in 0..<10 {
//    serialQueue.async {
//        print(i)
//        print(Thread.current)
//    }
//}
//
//
for i in 0..<10 {
    concurrentQueue.async {
        print(i)
        print(Thread.current)
    }
}
//
//
//for i in 0..<10 {
//    concurrentQueue.async {
//        print(i)
//        print(Thread.current)
//    }
//}

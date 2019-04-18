import UIKit


 8.truncatingRemainder(dividingBy: 2.5)

    11 % 4

/*:  Heading 1
 
 *  aaa
 * aaaaa
 */
11.0 / 4


let cafee = "Caf\u{0065}\u{0301}"
cafee.unicodeScalars.forEach { print($0) }
print("\n")
cafee.utf8.forEach { print($0) }
print("\n")
cafee.utf16.forEach { print($0) }

var mixStr = "Swift 3.0 is interesting!"


for (_, value) in mixStr.enumerated() {
    print("\(value)")
}

// 0: S
// 1: w
// 2: i
// 3: f
// 4: t
// 5: 很
// 6: 有
// 7: 趣
let a = mixStr[mixStr.startIndex]

let b = String(mixStr[mixStr.startIndex])

if let index = mixStr.firstIndex(of: "很") {
    mixStr.insert(contentsOf: "3.0", at: index)
}

let swiftView = mixStr.suffix(12).dropLast()
String(swiftView)

let strViews = mixStr.split(separator: " ")
strViews.map(String.init)
// ["Swift", "3.0", "is", "interesting!"]

let cc = mixStr.startIndex

let aaa = mixStr[cc]

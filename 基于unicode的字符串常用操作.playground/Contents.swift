import UIKit

let cafee = "caf\u{0065}\u{0301}"

let beg = cafee.startIndex
let fakeEnd = cafee.endIndex
let end = cafee.index(cafee.startIndex, offsetBy: 3)
cafee[beg ..< end]

String(cafee.characters.prefix(3))

var mixStr = "Swift很有趣"

for (index, value) in mixStr.characters.enumerated() {
    print("\(index): \(value)")
}

//插入内容
if let index = mixStr.characters.index(of: "很") {
    mixStr.insert(contentsOf: "3.0".characters, at: index)
}


//基于Range的查找和替换

if let cnIndex = mixStr.characters.index(of: "很") {
    mixStr.replaceSubrange(cnIndex ..< mixStr.endIndex, with: " is interesting!")
}

//字符串切片
let swiftView = mixStr.characters.suffix(12).dropLast()
String(swiftView)

let strViews = mixStr.characters.split(separator: " ")
strViews.map(String.init)

var i = 0
let singleCharViews = mixStr.characters.split { _ in
    if i > 0 {
        i = 0
        return true
    }
    else {
        i += 1
        return false
    }
}

print(singleCharViews.map(String.init))

//插入内容

var newStr = "Swift很有趣"

newStr[newStr.startIndex]
String(newStr.characters.prefix(5))

if let index = newStr.characters.index(of: "很") {
    mixStr.insert(contentsOf: "3.0".characters, at: index)
}

if let cnIndex = newStr.characters.index(of: "很") {
    newStr.replaceSubrange(cnIndex ..< newStr.endIndex, with: " is interesting!")
}


//测验

var rngStr = "皇族永不言弃"

//插入

if let index = rngStr.index(of: "永") {
    rngStr.insert(contentsOf: "RNG", at: index)
}

//替换

let begIndex = rngStr.index(rngStr.startIndex, offsetBy: 5)
rngStr.replaceSubrange(begIndex ..< rngStr.endIndex, with: " Never give up")



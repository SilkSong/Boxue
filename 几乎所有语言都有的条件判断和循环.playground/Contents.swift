var i = 0
while i < 10 {
    print(i)
    i += 1
}


repeat {
    print(i)
    i -= 1
} while i > 0

enum Direction {
    case north, south, east, west(abbr: String)
}

let test = Direction.west(abbr: "W")
if case .west = test {
    print(test) // west("W")
}

if case .west(let direction) = test {
    print(direction) // W
}

//在判断力通过 case 匹配的值 = 要检查的对象
//把匹配的内容绑定到变量，还可以绑定 enum 中的关联值
//自动提取 optional 的值
//自动绑定类型转换的结果： case let variable as Type 或者你仅仅想判断类型，而不需要知道具体内容，
//可以使用更简单的 is

enum Power {
    case fullyCharged
    case normal(percentage: Double)
    case outOfPower
}

let battery = Power.normal(percentage: 0.1)

//
//  main.swift
//  InterOperateCWithSwift
//
//  Created by Song Zixin on 2019/5/10.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import Foundation

//简单变量
var ten = global_ten

//自定义 Enum
let redColor: TrafficLightColor = .red
let redColorRawValue = redColor.rawValue
print(redColorRawValue)
print(redColor)

extension TrafficLightColor {
    static var blue: TrafficLightColor {
        return TrafficLightColor(rawValue: "Blue")
    }
}

print(TrafficLightColor.blue.rawValue)

//可拓展 Enum
extension Shape {
    static var ellipse: Shape {
        return Shape(4)
    }
}

let e: Shape = .ellipse
print(e.rawValue)


//固定参数个数的函数
let a: Int32 = 3
let b: Int32 = 5
//func add(_ m: Int32, _ n: Int32) -> Int32 {
//    return m + n
//}
let c = add(a,b)
print("c's value is \(c)")

//Struct
var origin = Location()
var eleven = Location(x: 1, y: 1)
print(origin.x)
print(eleven.y)






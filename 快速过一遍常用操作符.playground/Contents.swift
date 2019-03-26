import UIKit

var a = 20
let b = 3

let mod = a % b

// 8 % 2.5

8.truncatingRemainder(dividingBy: 2.5)


let sum = a + b
let isEqual = sum == 23
let isNotEqual = sum != 23

//Identity operator: === !==

//Ternary Conditional Operator

isEqual ? "Yes" : "No"

//Nil Coalescing Operator

let userInput: String? = "A user input"
userInput ?? "default input"

//Range Operator
for index in 1...3 {
    print(index)
}

//Logic Operator
let logicNot = !isEqual
let logicAnd = isEqual && isNotEqual
let logicOR = isEqual || isNotEqual


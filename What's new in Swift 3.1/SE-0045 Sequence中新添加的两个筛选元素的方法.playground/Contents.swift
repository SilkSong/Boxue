import UIKit

let factorialArray = sequence(state: (1,1), next: {
    (state: inout (Int, Int)) -> Int? in
    defer {
        state.0 = state.0 * state.1
        state.1 += 1
    }
    return state.0
})


factorialArray.prefix { $0 < 10000 }.drop { $0 < 100 }.forEach { print($0) }

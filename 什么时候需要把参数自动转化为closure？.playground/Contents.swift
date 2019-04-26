import UIKit
func logicAnd(_ l: Bool, _ r: @autoclosure () -> Bool) -> Bool {
    guard l else { return false }
    
    return r()
}

logicAnd(false, true)


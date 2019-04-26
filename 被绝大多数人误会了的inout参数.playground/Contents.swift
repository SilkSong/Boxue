import UIKit


func incremental(_ i: inout Int) -> Int {
    i = i + 1
    return i
}


struct Color {
    var r: Int
    var g: Int
    var b: Int
    
    var hex: Int {
        return r << 16 + g << 8 + b
    }
}

var red = Color(r: 255, g: 0, b: 0)

func doubleIncrement(_ i: inout Int) {
    func increment() {
        i += 1
    }
    
    [0, 1].forEach { _ in increment() }
}

var i = 2
doubleIncrement(&i) // 4

func incrementByReference(_ pointer: UnsafeMutablePointer<Int>) {
    pointer.pointee += 1
}

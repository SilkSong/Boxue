import UIKit

class Shape {
    enum Color { case red, yellow, green }
    
    func doDraw(of color: Color) {
        print("A \(color) shape.")
    }
}

extension Shape {
    func draw(color: Color = .red) {
        doDraw(of: color)
    }
}

class Square: Shape {
    override func doDraw(of color: Color) {
        print("A \(color) square.")
    }
    
}

class Circle: Shape {
    override func doDraw(of color: Color) {
        print("A \(color) circle.")
    }
}
let s = Square()
let c = Circle()

s.draw()
c.draw()



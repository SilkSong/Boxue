import UIKit


class Rectangle {
    var w: Double
    var h: Double
    
    init(w: Double, h: Double) {
        self.w = w
        self.h = h
    }
}

class SquareRectangle: Rectangle {
    init(edge: Double) {
        super.init(w: edge, h: edge)
    }
}

func scaleWidth(of rect: Rectangle) {
    let oldHeight = rect.h
    rect.w *= 1.1
    
    assert(oldHeight == rect.h)
}

var s11 = SquareRectangle(edge: 11)
scaleWidth(of: s11)

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



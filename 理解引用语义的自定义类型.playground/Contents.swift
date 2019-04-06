import UIKit

struct PointValue {
    var x: Int
    var y: Int
    
    mutating func move(to: PointValue) {
        self = to
    }
}



class PointRef {
    var x: Int
    var y: Int
    
    func move(to: PointRef) {
        self.x = to.x
        self.y = to.y
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

let p1 = PointRef(x: 0, y: 0)
var p2 = PointValue(x: 0, y: 0)
var p3 = p1
var p4 = p2
p1 === p3
p3.x = 10
p1.x
p4.x = 10
p2.x

p2.move(to: p4)
p2.x

class Point2D {
    var x: Double = 0
    var y: Double = 0

    init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }
    
    
    init?(xy: Double) {
        guard xy > 0 else { return nil }
        self.x = xy
        self.y = xy
    }
    
    convenience init(at: (Double, Double)) {
        self.init(x: at.0, y: at.1)
    }
    
    convenience init?(at: (String, String)) {
        guard let x = Double(at.0), let y = Double(at.1) else {
            return nil
        }
        self.init(at: (x, y))
    }
}


let origin = Point2D()

let point11 = Point2D(x: 11, y: 11)
let point22 = Point2D(at: (2.0, 2.0))
let point44 = Point2D(at: ("4.0", "4.0"))


class Point3D: Point2D {
    var z: Double = 0
    
    init(x: Double = 0, y: Double = 0, z: Double = 0) {
        //Phase 1
        self.z = z
        super.init(x: x, y: y)
        
        //Phase 2
        self.initXYZ(x: x, y: y, z: z)
    }
    
    override init(x: Double, y: Double) {
        self.z = 0
        super.init(x: x, y: y)
    }
    
    override init?(xy: Double) {
        if xy <= 0 { return nil }
        self.z = xy
        super.init(x: xy, y: xy)
    }
    
    func initXYZ(x: Double, y: Double, z: Double) {
        self.x = round(x)
        self.y = round(y)
        self.z = round(z)
    }
}

let origin3D = Point3D()
let point111 = Point3D(x: 1, y: 1)
let point222 = Point3D(xy: 2)
let point333 = Point3D(at: (3,3))
let point444 = Point3D(at: ("4","4"))





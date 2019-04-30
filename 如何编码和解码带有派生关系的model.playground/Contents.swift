import UIKit

class Point2D: Codable {
    var x = 0.0
    var y = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case x
        case y
    }
    
    init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.x = try container.decode(Double.self, forKey: .x)
        self.y = try container.decode(Double.self, forKey: .y)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
    }

}

class Point3D: Point2D {
    var z = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case z
        case point_2d
    }
    
    init(z: Double = 0) {
        self.z = z
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: container.superDecoder(forKey: .point_2d))
        self.z = try container.decode(Double.self, forKey: .z)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try super.encode(to: container.superEncoder(forKey: .point_2d))
        try container.encode(z, forKey: .z)
    }


}

func encode<T>(of model: T) throws where T: Codable {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    let data = try encoder.encode(model)
    print(String(data: data, encoding: .utf8)!)
}

//var p1 = Point3D()
//p1.x = 1
//p1.y = 1
//p1.z = 1
//try encode(of: p1)

let response = """
{
"z" : 1,
"point_2d" : {
"x" : 1,
"y" : 1
}
}
"""
let data = response.data(using: .utf8)!
let decoder = JSONDecoder()
let point3D = try! decoder.decode(Point3D.self, from: data)
dump(point3D)

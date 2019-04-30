import UIKit

struct Episode: Codable {
    let title: String
    let createdAt: Date
    let comment: String?
    let duration: Int
    let slices: [Float]
    
    enum CodingKeys: String, CodingKey {
        case title
        case createdAt = "created_at"
        case comment
        case meta
    }
    
    enum MetaCodingKeys: String, CodingKey {
        case duration
        case slices
    }
    
    init(title: String,
         createdAt: Date,
         comment: String?,
         duration: Int,
         slices: [Float]) {
        self.title = title
        self.createdAt = createdAt
        self.comment = comment
        self.duration = duration
        self.slices = slices
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
         self.title = try container.decode(String.self, forKey: .title)
        self.createdAt = try container.decode(
            Date.self, forKey: .createdAt)
        self.comment = try container.decodeIfPresent(String.self, forKey: .comment)
        
        let meta = try container.nestedContainer(keyedBy: MetaCodingKeys.self, forKey: .meta)
        self.duration = try meta.decode(
            Int.self, forKey: .duration)
        var unkeyedContainer = try meta.nestedUnkeyedContainer(forKey: .slices)
        var percentages: [Float] = []
        
        while (!unkeyedContainer.isAtEnd) {
            let sliceDuration = try unkeyedContainer.decode(Float.self)
            percentages.append(sliceDuration / Float(duration))
        }
        self.slices = percentages
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(comment, forKey: .comment)
        

        var meta = container.nestedContainer(keyedBy: MetaCodingKeys.self, forKey: .meta)
        try meta.encode(duration, forKey: .duration)
        var unkeyedContainer = meta.nestedUnkeyedContainer(forKey: .slices)
        try slices.forEach {
            try unkeyedContainer.encode(Float(duration) * $0)
        }
    }
    
    
}

//let episode = Episode(title: "How to parse a JSON", createdAt: Date(), comment: nil, duration: 500, slices: [0.25, 0.5, 0.75])
//
//let encoder = JSONEncoder()
//encoder.outputFormatting = .prettyPrinted
//encoder.dateEncodingStrategy = .custom({ (date, encoder) in
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
//    let stringData = formatter.string(from: date)
//    var container = encoder.singleValueContainer()
//
//    try container.encode(stringData)
//})
//
//let data = try! encoder.encode(episode)
//
//print(String(data: data, encoding: .utf8)!)

let response = """
{
"title": "How to parse a json - IV",
"comment": "null",
"created_at": "2017-08-24 00:00:00 +0800",
"meta": {
"duration": 500,
"slices": [125, 250, 375]
}
}
"""

let data = response.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
    let date = try decoder.singleValueContainer().decode(String.self)
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    return formatter.date(from: date)!
})
let episode = try! decoder.decode(Episode.self, from: data)

//dump(episode)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let encodedData = try encoder.encode(episode)

print(String(data: encodedData, encoding: .utf8)!)


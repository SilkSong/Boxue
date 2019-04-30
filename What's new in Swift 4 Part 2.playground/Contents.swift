import UIKit

let response = """
{
    "meta": {
        "total_exp": 1000,
        "level": "beginner",
        "total_duration": 120
    },
    "list": [
        {
            "title": "How to parse JSON in Swift 4 - I",
            "series": "What's new in Swift 4",
            "created_by": "Mars",
            "type": "free",
            "created_at": "2017-08-23T01:42:42Z",
            "duration": "NaN",
            "origin": "Ym94dWVpby5jb20=",
            "url": "boxueio.com"
        },
        {
            "title": "How to parse JSON in Swift 4 - II",
            "series": "What's new in Swift 4",
            "created_by": "Mars",
            "type": "free",
            "created_at": "2017-08-23T01:42:42Z",
            "duration": "NaN",
            "origin": "Ym94dWVpby5jb20=",
            "url": "boxueio.com"
        }
    ]
}
"""

struct EpisodePage: Codable {
    let meta: EpisodeMeta
    let list: [Episode]
    
    struct EpisodeMeta: Codable {
        let total_exp: Int
        let level: EpisodeLevel
        let total_duration: Int
        
        enum EpisodeLevel: String, Codable {
            case beginner
            case intermediate
            case advanced
        }
    }
    
    struct Episode: Codable {
        var title: String
        var series: String
        var createdBy: String
        var type: EpisodeType
        let createdAt: Date
        let duration: Float
        var origin: Data
        let url: URL
        
        enum CodingKeys: String, CodingKey {
            case title
            case series
            case type
            case createdAt = "created_at"
            case duration
            case createdBy = "created_by"
            case origin
            case url
        }
        
        enum EpisodeType: String, Codable {
            case free
            case paid
        }
        
        
        init(title: String, series: String, createdBy: String, type: EpisodeType, createdAt: Date, duration: Float, origin: Data, url: URL) {
            self.title = title
            self.series = series
            self.createdBy = createdBy
            self.type = type
            self.createdAt = createdAt
            self.duration = duration
            self.origin = origin
            self.url = url
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(title, forKey: .title)
            try container.encode(series, forKey: .series)
            try container.encode(type, forKey: .type)
            try container.encode(createdBy, forKey: .createdBy)
            try container.encode(createdAt, forKey: .createdAt)
            try container.encode(duration, forKey: .duration)
            try container.encode(origin, forKey: .origin)
            try container.encode(url, forKey: .url)
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.title = try container.decode(String.self, forKey: .title)
            self.series = try container.decode(String.self, forKey: .series)
            self.createdBy = try container.decode(String.self, forKey: .createdBy)
            self.type = try container.decode(EpisodeType.self, forKey: .type)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.duration = try container.decode(Float.self, forKey: .duration)
            self.origin = try container.decode(Data.self, forKey: .origin)
            self.url = try container.decode(URL.self, forKey: .url)
        }
    }
}

let decodeData = response.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
decoder.dataDecodingStrategy = .base64

var decodeEpisode = try! decoder.decode(EpisodePage.self, from: decodeData)

dump(decodeEpisode)


//Encode
//let encodeEpisode = Episode(
//    title: "How to parse JSON in Swift 4",
//    series: "What's new in Swift 4",
//    createdBy: "Mars",
//    type: .free,
//    createdAt: Date(),
//    duration: 6.2)
//
//let encoder = JSONEncoder()
//encoder.dateEncodingStrategy = .iso8601
//encoder.outputFormatting = .prettyPrinted
//let encodeData = try! encoder.encode(encodeEpisode)
//print(String(data: encodeData, encoding: .utf8)!)

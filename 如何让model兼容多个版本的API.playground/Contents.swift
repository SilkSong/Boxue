import UIKit

let responseOld = """
{
    "created_at": "Oct-24-2017"
}
"""
    
let responseNew = """
{
        "created_at" : "2017-08-28T00:24:10+0800"
}
"""

struct Episode: Codable {
    var createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
    }
    

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let options = encoder.userInfo[EpisodeCodingOptions.infoKey] as?
            EpisodeCodingOptions {
            let date = options.dateFormatter.string(from: createdAt)
            try! container.encode(date, forKey: .createdAt)
        } else {
            fatalError("Can not read coding options")
        }
    }
}

struct EpisodeCodingOptions {
    enum Version {
        case v1
        case v2
    }
    
    let apiVersion: Version
    let dateFormatter: DateFormatter
    
    static let infoKey = CodingUserInfoKey(rawValue: "io.boxue.episode-coding-options")!
}


func encode<T>(of model: T,
               options: [CodingUserInfoKey: Any]!) throws where T: Codable {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    if options != nil {
        encoder.userInfo = options
    }
    
    let data = try encoder.encode(model)
    print(String(data: data, encoding: .utf8)!)
}

let formatter = DateFormatter()
//formatter.dateFormat = "MMM-dd-yyyy"
formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
let oldAPIOption = EpisodeCodingOptions(apiVersion: .v2, dateFormatter: formatter)

let episode = Episode(createdAt: Date())
try encode(of: episode, options: [EpisodeCodingOptions.infoKey: oldAPIOption])


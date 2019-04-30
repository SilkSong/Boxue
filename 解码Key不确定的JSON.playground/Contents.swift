import UIKit

let response = """
{
    "1":{
    "title": "Episode 1"
    },
    "2": {
    "title": "Episode 2"
    },
    "3": {
    "title": "Episode 3"
    },
    "4": {
    "title": "Episode 4"
    }
}
"""

struct Episodes: Codable {
    struct EpisodeInfo: CodingKey {
        var stringValue: String
        var intValue: Int? {
            return nil
        }
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            return nil
        }
        static let title = EpisodeInfo(stringValue: "title")!
    }
    
    struct Episode: Codable {
        let id: Int
        let title: String
    }
    
    var episodes: [Episode] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EpisodeInfo.self)
        
        let v = [Episode]()
        for key in container.allKeys {
            let innerContainer = try container.nestedContainer(keyedBy: EpisodeInfo.self, forKey: key)
            let title = try innerContainer.decode(String.self, forKey: .title)
            let episode = Episode(id: Int(key.stringValue)!, title: title)
        }
        self.episodes = v
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EpisodeInfo.self)
        
        for episode in episodes {
            let id = EpisodeInfo(stringValue: String(episode.id))!
            var nested = container.nestedContainer(keyedBy: EpisodeInfo.self, forKey: id)
            try nested.encode(episode.title, forKey: .title)
        }
        
    }
}

func decode<T>(response: String, of: T.Type) throws where T: Codable {
    let data = response.data(using: .utf8)!
    let decoder = JSONDecoder()
    let model = try decoder.decode(T.self
        , from: data)
    dump(model)
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

//try decode(response: response, of: Episodes.self)
try encode(
    of: decode(response: response, of: Episodes.self),
    options: nil)

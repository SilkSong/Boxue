import UIKit

let a = 2.33
let b = Int(a)

struct Apple {
    var weightInGram: Int
    
    init?(json: [String: Any]) {
        guard let weightInString = json["weight"] as? String,
            let weightInDouble = Double(weightInString),
            let weight = Int(exactly: weightInDouble)
            else {
                return nil
        }
        
        self.weightInGram = weight
    }
}

let applesData = "[{\"weight\":\"500.0\"},{\"weight\":\"500.1\"},{\"weight\":\"499.9\"}]"

print(applesData)
let data = applesData.data(using: .utf8)!

func filterApple(from data: Data) -> [Apple] {
    guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
        let dataArray = json as? [[String: Any]]
        else {
            return []
    }
    return dataArray.flatMap(Apple.init)
}

let apples = filterApple(from: data)

print(apples.count)
apples.forEach { print($0) }

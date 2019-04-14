import UIKit


enum JSON {
    case intValue(Int)
    case stringValue(String)
    case arrayValue(Array<JSON>)
    case dictionaryValue(Dictionary<String, JSON>)
}

extension JSON {
    subscript(dynamicMember member: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[member]
        }
        return nil
    }
}

extension JSON {
    var stringValue: String? {
        if case .stringValue(let str) = self {
            return str
        }

        return nil
    }

    var intValue: Int? {
        if case .intValue(let str) = self {
            return str
        }

        return nil
    }
}

extension JSON {
    subscript(index: Int) -> JSON? {
        if case .arrayValue(let array) = self {
            return index < array.count ? array[index] : nil
        }

        return nil
    }

    subscript(key: String) -> JSON? {
        if case .dictionaryValue(let dic) = self {
            return dic[key]
        }

        return nil
    }
}

let json = JSON.dictionaryValue(
    ["series": .arrayValue(
        [.dictionaryValue(["title": .stringValue("What's new in Swift 4.2?")]),
         .dictionaryValue(["count": .intValue(5)])])
    ])

json["series"]?[0]?["title"]?.stringValue



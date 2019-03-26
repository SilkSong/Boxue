import UIKit

enum RecordType {
    case bool(Bool)
    case number(Int)
    case text(String)
}

let defaultRecord: [String: RecordType] = [
    "uid": .number(0),
    "exp": .number(100),
    "favourite": .bool(false),
    "title": .text("")
]


var template = defaultRecord
var record11Patch: [String: RecordType] = [
    "uid": .number(11),
    "title": .text("Common dictionary extensions")
]

//template.merge(record11Patch)

extension Dictionary {
    mutating func merge<S: Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            sequence.forEach { self[$0] = $1 }
    }
    
    init<S: Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            self = [:]
            self.merge(sequence)
    }
}

let record11PatchDic = Dictionary(record11Patch)
//record11PatchDic.forEach { print("\($0): \($1)") }

print(record11PatchDic.map { $1 })



template.merge(record11Patch)



let record10Patch: [(key: String, value: RecordType)] = [
    ("uid", .number(10)),
    ("title", .text("Common dictionary extensions"))
]

var template1 = defaultRecord
template1.merge(record10Patch)

//template1.forEach { print("\($0): \($1)") }

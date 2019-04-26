import UIKit

final class Episode: NSObject {
    @objc var title: String
    @objc var type: String
    @objc var length: Int
    
    override var description: String {
        return title + "\t" + type + "\t" + String(length)
    }
    
    init(title: String, type: String, length: Int) {
        self.title = title
        self.type = type
        self.length = length
    }
}

let episodes = [
    Episode(title: "title 1", type: "Free", length: 520),
    Episode(title: "title 4", type: "Paid", length: 500),
    Episode(title: "title 2", type: "Free", length: 330),
    Episode(title: "title 5", type: "Paid", length: 260),
]


type(of: episodes)

//let typeDescriptor = NSSortDescriptor(
//    key: #keyPath(Episode.type),
//    ascending: true,
//    selector: #selector(NSString.localizedCompare(_:)))
//
//let lengthDescriptor = NSSortDescriptor(
//    key: #keyPath(Episode.length),
//    ascending: true)
//
//let descriptors = [typeDescriptor, lengthDescriptor]
//let sortedEpisodes = (episodes as NSArray).sortedArray(using: descriptors)
//
//sortedEpisodes.forEach { print($0 as! Episode)}

//我们还是得从NSSortDescriptor的思路入手，把排序规则的表达、排序规则的组合，以及执行排序的动作独立分开。只是，为了充分利用Swift编译器提供类型检查，我们要避免使用运行时机制来识别要访问的内容。大体的思路是这样的，对于比较元素时执行的函数，我们可以去掉selector，直接用Swift中的函数类型。而对于获取要排序的属性，我们也要通过一个函数类型来表达，而不要通过Key-Value coding。在下一节中，我们就基于这个思路，用Swift自身的方式，来模拟OC的这两个运行时特性。


//一个接受两个同类型的参数，并且返回Bool的函数
typealias SortDescriptor<T> = (T, T) -> Bool

//let stringDescriptor: SortDescriptor<String> = {
//     $0.localizedCompare($1) == .orderedAscending
//}



func makeDescriptor<Key, Value>(key: @escaping (Key) -> Value,
                                _ isAscending: @escaping (Value, Value) -> Bool) -> SortDescriptor<Key> {
    return { isAscending(key($0), key($1)) }
}

//let stringDescriptor: SortDescriptor<String> = {
//    $0.localizedCompare($1) == .orderedAscending
//}
//
let lengthDescriptor: SortDescriptor<Episode> = makeDescriptor(key: { $0.length }, <)

let typeDescriptor: SortDescriptor<Episode> =
makeDescriptor(key: { $0.type }, {
    $0.localizedCompare($1) == .orderedAscending
})

//episodes.sorted(by: typeDescriptor).forEach { print($0) }


func combine<T>(rules: [SortDescriptor<T>]) -> SortDescriptor<T> {
    return { l, r in
        for rule in rules {
            if rule(l, r) {
                return true
            }
            
            if rule(r, l) {
                return false
            }

        }
        
        return false
    }
}

let mixDescriptor = combine(rules: [typeDescriptor])
episodes.sorted(by: mixDescriptor).forEach { print($0) }

let numbers = ["Five", "4", "3", "2", "1"]

let intDescriptor: SortDescriptor<String> =
    makeDescriptor(key: { Int($0) }, <)

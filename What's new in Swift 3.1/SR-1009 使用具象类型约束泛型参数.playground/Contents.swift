import UIKit

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

3.isEven

protocol IntValue {
    var value: Int { get }
}

extension Int: IntValue {
    var value: Int { return self }
}

extension Optional where Wrapped: IntValue {
    var isEven: Bool {
        guard let value = self?.value else {
            return false
        }
        
        return value % 2 == 0
    }
}

var foo: Int? = 3
foo?.isEven


extension String {
    var containsA: Bool {
        return contains("a")
    }
}

let b = "a cup"
b.containsA



protocol StringValue {
    var value: String { get }
}

extension String: StringValue {
    var value: String { return self}
}


//extension Optional where Wrapped: StringValue {
//    var containsA: Bool {
//        guard let value = self?.value else {
//            return false
//        }
//        return value.contains("a")
//    }
//}

extension Optional where Wrapped == String {
    var containsA: Bool {
        guard let value = self else {
            return false
        }
        return value.contains("a")
    }
}


let optionalB: String? = "a cup"
optionalB.containsA

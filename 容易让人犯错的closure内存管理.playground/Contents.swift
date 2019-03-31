import UIKit

var i = 10
var captureI = { [i] in print(i) }
i = 11

captureI()

class Demo { var value = "" }

var c = Demo()
var captureC = { [c] in print(c.value) }
c.value = "updated"

c = Demo()
captureC()

class Role {
    var name: String
    lazy var action: () -> Void = {
        print("\(self) takes action.")
    }
    
    init(_ name: String = "Foo") {
        self.name = name
        print("\(self) init")
    }
    
    deinit {
        print("\(self) deinit")
    }
}

extension Role: CustomStringConvertible {
    var description: String {
        return "<Role: \(name)>"
    }
}

if true {
    var boss = Role("boss")
    let fn = { [unowned boss] in
        print("\(boss) takes action.")
    }
    boss = Role("hidden boss")
    boss.action = fn
    
    boss.action()
}

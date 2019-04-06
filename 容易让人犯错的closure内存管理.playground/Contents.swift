import UIKit

//var i = 10
//var captureI = { [i] in print(i) }
//i = 11
//
//captureI()
//
//class Demo { var value = "" }
//
//var c = Demo()
//var captureC = { [c] in print(c.value) }
//c.value = "updated"
//
//c = Demo()
//captureC()

class Role {
    var name: String
    lazy var action: () -> Void = { [weak self] in
        if let role = self {
            print("\(role) takes action.")
        }
    }
    
    init(_ name: String = "Foo") {
        self.name = name
        print("\(self) init")
    }
    
    deinit {
        print("\(self) deinit")
    }
    
    func levelUp() {
        let globalQueue = DispatchQueue.global()
        
        globalQueue.async { [weak self] in 
            print("Before: \(self) level up")
            usleep(1000)
            print("After: \(self) level up")
        }
    }
}

extension Role: CustomStringConvertible {
    var description: String {
        return "<Role: \(name)>"
    }
}
//
//if true {
//    var boss = Role("boss")
//    let fn = { [unowned boss] in
//        print("\(boss) takes action.")
//    }
//   boss.action = fn
//    boss = Role("hidden boss")
//
//
//    boss.action()
//
//}

var player: Role? = Role("P1")
player?.levelUp()

usleep(500)

print("Player set to nil")
player = nil

dispatchMain()

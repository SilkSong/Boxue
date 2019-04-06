import UIKit


class Role {
    typealias PowerFn = (Role) -> Int
    
    var powerFn: PowerFn
    
    init(powerFn: @escaping PowerFn = defaultPower) {
        self.powerFn = powerFn
    }
}

extension Role {
    func power() -> Int {
        return powerFn(self)
    }
}

func defaultPower(role: Role) -> Int {
    return 0
}

class Player: Role {
    fileprivate func doPower() -> Int {
        return 100
    }
}

let p1 = Player(powerFn: { _ in 100 })
let p2 = Player(powerFn: { _ in 200 })

p1.powerFn = { _ in 50 }

enum Level {
    case simple, normal, hard
    
    func rolePower(role: Role) -> Int {
        switch self {
        case .simple:
            return 300
        case .normal:
            return 200
        case .hard:
            return 100
        }
    }
}


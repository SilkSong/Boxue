import UIKit

enum Direction {
    case north, south, east, west(abbr: String)
}

let west = Direction.west(abbr: "W")

if case .west = west {
    print(west) // west("W")
}

enum Power {
    case fullyCharged
    case normal(percentage: Double)
    case outOfPower
}

let battery = Power.normal(percentage: 0.1)

switch battery {
case .normal(let percentage) where percentage <= 0.1:
    print("Almost out of power")
case .normal(let percentage) where percentage >= 0.8:
    print("Almost fully charged")
default:
    print("Normal battery status")
}

if case .normal(let percentage) = battery,
    case 0...0.1 = percentage {
    print("Almost out of power")
}

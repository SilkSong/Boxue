import UIKit

enum Result<T> {
    case success(T)
    case failure(Error)
}


struct Car {
    var fuelInLitre: Double
    var no: String
    func start() throws -> String {
        guard fuelInLitre > 5 else {
            // How we express the error here?
            throw CarError.outOfFuel(no: no, fuelInLitre: fuelInLitre)
        }
        
        return "Ready to go"
    }
}


enum CarError: Error {
    case outOfFuel(no: String, fuelInLitre: Double)
}

var vwGroup: [Car] = []

(1...1000).forEach {
    let amount = Double(arc4random_uniform(70))
    vwGroup.append(Car(fuelInLitre: amount, no: "Car-\($0)"))
}

extension Sequence {
    func checkAll(by rule:
        (Iterator.Element) throws -> Bool) rethrows -> Bool {
        
        for element in self {
            guard try rule(element) else { return false }
        }
        
        return true
    }
}


//do {
//    let message = try vw.start()
//    print(message)
//} catch CarError.outOfFuel {
//    print("Cannot start due to out of fuel")
//} catch {
//    print("We have something wrong")
//}

import UIKit

class FinishAlertView {
    var buttons: [String] = [ "Cancel", "The next" ]
    var buttonPressed: ((Int) -> Void)?
    
    func goToTheNext() {
        buttonPressed?(1)
    }
}

class PressCounter {
    var count = 0
    
    func buttonPressed(at Index: Int) {
        self.count += 1
    }
}

let fav = FinishAlertView()
var counter = PressCounter()

fav.buttonPressed = counter.buttonPressed

fav.goToTheNext()
fav.goToTheNext()
fav.goToTheNext()
fav.goToTheNext()
fav.goToTheNext()
fav.goToTheNext()

counter.count // 6

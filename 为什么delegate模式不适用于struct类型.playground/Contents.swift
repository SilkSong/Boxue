import UIKit

protocol FinishAlertViewDelegate {
    mutating func buttonPressed(at index: Int)
}

class FinishAlertView {
    var buttons: [String] = [ "Cancel", "The next" ]
    var delegate: FinishAlertViewDelegate?
    
    func goToTheNext() {
        delegate?.buttonPressed(at: 1)
    }
}


struct PressCounter: FinishAlertViewDelegate {
    var count = 0
    
    mutating func buttonPressed(at Index: Int) {
        self.count += 1
        print("count is \(count)")
    }
}

class EpisodeViewController: FinishAlertViewDelegate {
    var episodeAlert: FinishAlertView!
    var counter: PressCounter!
    
    init() {
        
        self.episodeAlert = FinishAlertView()
        self.counter = PressCounter()
        self.episodeAlert.delegate = self.counter
    }
    
    // 3. Implement interface
    func buttonPressed(at index: Int) {
        print("Go to the next episode...")
    }
}

let evc = EpisodeViewController()
evc.episodeAlert.goToTheNext()
evc.episodeAlert.goToTheNext()
evc.episodeAlert.goToTheNext()
print("evc.count is \(evc.counter.count)")
print("evc.count is \((evc.episodeAlert.delegate as! PressCounter).count)")



//evc.episodeAlert.goToTheNext()
//evc.episodeAlert.goToTheNext()
//evc.episodeAlert.goToTheNext()
//evc.episodeAlert.goToTheNext()
//evc.episodeAlert.goToTheNext()
//evc.episodeAlert.goToTheNext()
//
//evc.counter.count // Still 0
//(evc.episodeAlert.delegate as! PressCounter).count

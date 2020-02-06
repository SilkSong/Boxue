//
//  AboutYouViewController.swift
//  ReactiveLogin
//
//  Created by Song Zixin on 2020/2/1.
//  Copyright © 2020 Song Zixin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AboutYouViewController: UIViewController {

    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var male: UIButton!
    @IBOutlet weak var female: UIButton!
    @IBOutlet weak var knowSwift: UISwitch!
    @IBOutlet weak var swiftLevel: UISlider!
    @IBOutlet weak var passionToLearn: UIStepper!
    @IBOutlet weak var heartHeight: NSLayoutConstraint!
    @IBOutlet weak var update: UIButton!
    
    var bag: DisposeBag! = DisposeBag()
    
    enum Gender {
        case notSelected
        case male
        case female
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DatePicker
        self.birthday.layer.borderWidth = 1
        let birthdayObservable = birthday.rx.date.map {
            InputValidator.isValidDate($0)
        }
        birthdayObservable.map {
            $0 ? UIColor.green : UIColor.clear
        }.subscribe(onNext: {
            self.birthday.layer.borderColor = $0.cgColor
            }).disposed(by: bag)
        
        //GenderPicker
        //As Observer
        let genderSelection = BehaviorSubject<Gender>(value: .notSelected)
        self.male.rx.tap.map {
            return Gender.male
        }.bind(to: genderSelection)
            .disposed(by: bag)
        self.female.rx.tap.map {
            return Gender.female
        }.bind(to: genderSelection)
        .disposed(by: bag)
        //As Observable
        genderSelection.subscribe(onNext: {
            switch $0 {
            case .male:
                self.male.setImage(UIImage(named: "check"), for: .normal)
                self.female.setImage(UIImage(named: "uncheck"), for: .normal)
            case .female:
                self.male.setImage(UIImage(named: "uncheck"), for: .normal)
                self.female.setImage(UIImage(named: "check"), for: .normal)
            default:
                break;
            }
            }).disposed(by: bag)
        
        //Update Button
        Observable.combineLatest(birthdayObservable, genderSelection, resultSelector: { (birthday, gender) in
            if gender != .notSelected && birthday {
                return true
            } else {
                return false
            }
        }).bind(to: self.update.rx.isEnabled)
            .disposed(by: bag)
        
        //KnowSwift Switch
        self.knowSwift.rx.value.map {
            $0 ? 0.25 : 0
        }.bind(to: self.swiftLevel.rx.value)
            .disposed(by: bag)
        
        //swiftLevel Slider
        self.swiftLevel.rx.value.map {
            $0 != 0 ? true : false
        }.bind(to: self.knowSwift.rx.value)
            .disposed(by: bag)
    
        self.passionToLearn.rx.value.skip(1).subscribe(onNext: {
            self.heartHeight.constant = CGFloat($0 - 10)
            print(self.heartHeight.constant)

            //print(heartIma)
        }).disposed(by: bag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

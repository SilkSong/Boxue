//
//  ViewController.swift
//  ReactiveLogin
//
//  Created by Song Zixin on 2020/1/29.
//  Copyright © 2020 Song Zixin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
 
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var register: UIButton!
    
    var bag: DisposeBag! = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.email.layer.borderWidth = 1
        self.password.layer.borderWidth = 1

        // Do any additional setup after loading the view.
        
        let emailRxText = self.email.rx.text
        let emailObservable = emailRxText.map {
            (input: String?) -> Bool in
            return InputValidator.isValidEmail(input!)
        }
        emailObservable.map { (valid: Bool) -> UIColor in
            let color = valid ? UIColor.green : UIColor.clear
            return color
        }.subscribe(onNext: {
            self.email.layer.borderColor = $0.cgColor
        }).disposed(by: self.bag)
        
        //Password TextField
        let passwordRxText = self.password.rx.text
        let passwordObservable = passwordRxText.map {
            InputValidator.isValidPassword($0!)
        }
        passwordObservable.map {
            $0 ? UIColor.green : UIColor.clear
        }.subscribe(onNext: {
            self.password.layer.borderColor = $0.cgColor
        }).disposed(by: self.bag)
        
        //Sign up Button
//        Observable.combineLatest(emailObservable, passwordObservable, resultSelector: {
//            $0 && $1
//        }).subscribe(onNext: {
//            self.register.isEnabled = $0
//        })
//        .disposed(by: bag)

    }
    
}


//
//  ViewController.swift
//  FilterNumber
//
//  Created by Song Zixin on 2020/1/26.
//  Copyright © 2020 Song Zixin. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        var evenNumberObservable =
            Observable.of("1", "2", "3", "4", "5", "6", "7", "8", "9")
                .map { Int($0) }
                .filter {
                    if let item = $0, item % 2 == 0 {
                        print("Even: \(item)")
                        return true
                    }

                    return false
                }

        evenNumberObservable.subscribe { event in
            print("Event: \(event)")
    }

}
    
}

extension ViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let n = Int(string) {
            if n % 2 == 0 {
                print("Even: \(n)")
            }
        }
        
        return true
    }
}


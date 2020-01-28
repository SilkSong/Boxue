//
//  ViewController.swift
//  RxPractice
//
//  Created by Song Zixin on 2020/1/28.
//  Copyright © 2020 Song Zixin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var interval: Observable<Int>!
    var subscription: Disposable!
    var bag = DisposeBag()
    
    @IBOutlet weak var counter: UITextField!
    
    @IBOutlet weak var disposeCounter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interval = Observable.interval(.milliseconds(500), scheduler: MainScheduler.instance)
        
        self.subscription = interval.map {
            String($0)
        }.subscribe(onNext: {
            self.counter.text = $0
            })
        subscription.disposed(by: bag)
        
        self.disposeCounter.rx.tap.subscribe(onNext: {
            print("Dispose interval")
//            self.subscription.dispose()
            self.bag = DisposeBag()
        })
    }
        
}

//
//  ViewController.swift
//  理解Swift中方法的派发机制
//
//  Created by Song Zixin on 2019/4/7.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        

        let b = Base()
        b.method1() // breakpoint  1
        
        let s = Subclass()
        s.method1() // breakpoint 2
    }


}

class Base {
    func method1() {}
}

class Subclass: Base {
    override func method1() {}
    func method2() {}
}


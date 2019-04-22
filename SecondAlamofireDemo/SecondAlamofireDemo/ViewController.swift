//
//  ViewController.swift
//  SecondAlamofireDemo
//
//  Created by Song Zixin on 2019/4/22.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var downloadUrl: UITextField!
    
    @IBOutlet weak var beginBtn: UIButton!
    
    @IBOutlet weak var suspendOrResumeBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    
    @IBAction func valueChanged(_ sender: UITextField) {
        print("text field: \(String(describing: sender.text))")
        
        if sender.text != "" {
            self.beginBtn.isEnabled = true
        }
        else {
            self.beginBtn.isEnabled = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


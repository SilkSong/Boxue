//
//  ViewController.swift
//  RockScissorPaper
//
//  Created by Mars on 12/30/15.
//  Copyright © 2015 Boxue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var doraChoice: UIImageView!
    @IBOutlet weak var yourChoice: UIImageView!
    
    var choices = ["rock", "scissor", "paper"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doraChoice.image = UIImage(named: "rock")
        yourChoice.image = UIImage(named: "paper")
    }
    
    func getResult(_ myChoiceIndex: Int) -> String {
        if myChoiceIndex == 0 {
            return "Equal"
        }
        else if myChoiceIndex == 1 {
            return "Dora wins!"
        }
        else {
            return "You Win!"
        }
    }
    
    @IBAction func gameBegin(sender: UIButton) {
        doraChoice.image = UIImage(named: "rock")
        let randomIndex = Int.random(in: 0...2)
        self.yourChoice.image = UIImage(named: choices[randomIndex])

        let title = "Game result"
        let message = self.getResult(randomIndex)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

}



















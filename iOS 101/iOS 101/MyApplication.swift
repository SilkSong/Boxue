//
//  MyApplication.swift
//  iOS 101
//
//  Created by Song Zixin on 2019/4/21.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit

class MyApp: UIApplication {
    override func sendEvent(_ event: UIEvent) {
        print("Event: \(event)")
        
        super.sendEvent(event)
    }
}

//
//  MyView.swift
//  iOS 101
//
//  Created by Song Zixin on 2019/4/21.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit

class MyView: UIView {
    override func didAddSubview(_ subview: UIView) {
        print("Subview add")
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        print("Subview removed")
        
    }

}

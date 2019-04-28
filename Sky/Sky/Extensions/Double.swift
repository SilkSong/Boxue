//
//  Double.swift
//  Sky
//
//  Created by Song Zixin on 2019/4/28.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import Foundation

extension Double {
    func toCelcius() -> Double {
        return (self - 32.0) / 1.8
    }
}

//
//  Configuration.swift
//  Sky
//
//  Created by Song Zixin on 2019/4/27.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit
struct API {
    static let key = "fdc64a206756fec62ad71bc932b2e6d0"
    static let baseUrl = URL(string: "https://api.darksky.net/forecast")!
    static let authenticatedUrl = baseUrl.appendingPathComponent(key)
    
}

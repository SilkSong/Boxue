//
//  ForcastData.swift
//  Sky
//
//  Created by Song Zixin on 2019/4/29.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import Foundation

struct ForecastData: Codable {
    let time: Date
    let temperatureLow: Double
    let temperatureHigh: Double
    let icon: String
    let humidity: Double
}

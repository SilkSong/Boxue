//
//  WeatherData.swift
//  Sky
//
//  Created by Song Zixin on 2019/4/27.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeather
    
    struct CurrentWeather: Codable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
}

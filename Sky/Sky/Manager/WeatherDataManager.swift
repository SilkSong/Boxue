//
//  WeatherDataManager.swift
//  Sky
//
//  Created by Song Zixin on 2019/4/27.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit

final class WeatherDataManager {
    private let baseURL: URL
    
    private init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    static let shared = WeatherDataManager(baseURL: API.authenticatedUrl)
    
    typealias CompletionHandler = (WeatherData?, DataManagerError?) -> Void
    
    func weatherDataAt(
        latitude: Double,
        longitude: Double,
        completion: @escaping CompletionHandler) {
        //1. Concatenate the URL
        let url = baseURL.appendingPathComponent("\(latitude), \(longitude)")
        var request = URLRequest(url: url)
        
        //2. Set HTTP Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        //3. Launch the request
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            //4. Get the response here
        }).resume()
    }
    
    enum DataManagerError: Error {
        case failedRequest
        case invalidResponse
        case unknown
    }
    
}

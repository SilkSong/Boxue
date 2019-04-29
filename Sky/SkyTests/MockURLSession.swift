//
//  MockURLSession.swift
//  SkyTests
//
//  Created by Song Zixin on 2019/4/28.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import Foundation
@testable import Sky

class MockURLSession: URLSessionProtocol {
    
    enum DataManagerError: Error {
        case failedRequest
        case invalidResponse
        case unknown
    }

    
    var responseData: Data?
    var responseHeader: HTTPURLResponse?
    var responseError: Error?
    
    var sessionDataTask = MockURLSessionDataTask()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping dataTaskHandler) -> URLSessionDataTaskProtocol {
        completionHandler(responseData, responseHeader, responseError)
        return sessionDataTask
    }
}

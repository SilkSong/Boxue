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
    func dataTask(with request: URLRequest, completionHandler: @escaping dataTaskHandler) -> URLSessionDataTask {
        return URLSessionDataTask()
    }
}

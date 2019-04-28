//
//  MockURLSessionDataTask.swift
//  SkyTests
//
//  Created by Song Zixin on 2019/4/28.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import Foundation
@testable import Sky

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var isResumeCalled = false
    func resume() {
        self.isResumeCalled = true
    }
}

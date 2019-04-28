//
//  URLSession.swift
//  Sky
//
//  Created by Song Zixin on 2019/4/28.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping  dataTaskHandler) -> URLSessionDataTaskProtocol {
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

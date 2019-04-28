//
//  URLSessionProtocol.swift
//  Sky
//
//  Created by Song Zixin on 2019/4/28.
//  Copyright © 2019 SilkSong. All rights reserved.
//
import Foundation

protocol URLSessionProtocol {
    typealias dataTaskHandler = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping dataTaskHandler) -> URLSessionDataTaskProtocol
}



//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Song Zixin on 2019/4/22.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let ephemeralManager: SessionManager = {
//            // Get additional header
//            let defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//
//            // Set configuration
//            let configuration = URLSessionConfiguration.ephemeral
//            configuration.httpAdditionalHeaders = defaultHeaders
//
//            // Generate manger
//            return Alamofire.SessionManager(configuration: configuration)
//        }()
        
//        let parameters: Parameters = [
//            "foo": "bar",
//            "baz": ["a", 1],
//            "qux": [
//                "x": 1,
//                "y": 2,
//                "z": 3
//            ]
//        ]
        
        let user = "user"
        let password = "password"
        
        Alamofire.request("https://httpbin.org/basic-auth/\(user)/\(password)")
            .authenticate(user: user, password: password)
            .responseJSON { response in
                debugPrint(response)
        }
        
//        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters)
//        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding:  URLEncoding.default)
//        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        
        
//        Alamofire.request("https://httpbin.org/get").response { response in
//            print("Request: \(String(describing: response.request))")  // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//
//            print("Data: \(String(describing: response.data))")
//            print(type(of: response.data))
//
//            print("Error: \(String(describing: response.error))")
//            print(type(of: response.error))
//
//        }
        
//            .responseString(completionHandler: { response in
//                print("String: ===========")
//
//                switch response.result {
//                case .success(let str):
//                    print("\(type(of: str))")
//                    print(str)
//                case .failure(let error):
//                    print("\(error)")
//                }
//        })
        
//            .responseJSON(completionHandler: { response in
//                print("JSON ===========")
//
//                switch response.result {
//                case .success(let json):
//                    let dict = json as! Dictionary<String, AnyObject>
//                    let origin = dict["origin"] as! String
//                    let headers = dict["headers"] as! Dictionary<String, String>
//
//                    print("origin: \(origin)")
//                    let ua = headers["User-Agent"]
//                    print("UA: \(String(describing: ua))")
//
//                case .failure(let error):
//                    print("\(error)")
//                }
//            })
        
    }
        
}


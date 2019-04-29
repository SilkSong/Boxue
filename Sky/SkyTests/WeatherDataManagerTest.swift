//
//  WeatherDataManagerTest.swift
//  SkyTests
//
//  Created by Song Zixin on 2019/4/28.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import XCTest
@testable import Sky

class WeatherDataManagerTest: XCTestCase {
    let url = URL(string: "https://darksky.net")!
    var session: MockURLSession!
    var manager: WeatherDataManager!
    

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.session = MockURLSession()
        self.manager = WeatherDataManager(baseURL: url, urlSession: session)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_weatherDataAt_starts_the_session() {
        let dataTask = MockURLSessionDataTask()
        session.sessionDataTask = dataTask
        
        manager.weatherDataAt(latitude: 52, longitude: 100, completion: { _, _ in  })
        
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }
    
    func test_weatherDataAt_gets_data() {
        let expect = expectation(description: "Loading data from \(API.authenticatedUrl)")
        var data: WeatherData? = nil

        WeatherDataManager.shared.weatherDataAt(latitude: 52, longitude: 100, completion: { (response, error) in
            data = response
            expect.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(data)
    }
    
    func test_weatherDataAt_handle_invalid_request() {
        session.responseError = NSError(domain: "Invalid Request", code: 100, userInfo: nil)
    
        var error: WeatherDataManager.DataManagerError? = nil
        manager.weatherDataAt(latitude: 52, longitude: 100, completion: {
            (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, WeatherDataManager.DataManagerError.failedRequest)
    }
    
    func test_weatherDataAt_handle_statuscode_not_equal_to_200() {
        session.responseHeader = HTTPURLResponse(
            url: url, statusCode: 400,
            httpVersion: nil,
            headerFields: nil)
        
        let data = "{}".data(using: .utf8)!
        session.responseData = data
        
        var error: WeatherDataManager.DataManagerError? = nil
        
        manager.weatherDataAt(
            latitude: 52,
            longitude: 100,
            completion: {
                (_, e) in
                error = e
        })
        
        XCTAssertEqual(error, WeatherDataManager.DataManagerError.failedRequest)
        
        func test_weatherDataAt_handle_invalid_response() {

            session.responseHeader = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)
            
            /// Make a invalid JSON response here
            let data = "{".data(using: .utf8)!
            session.responseData = data
            
            var error: WeatherDataManager.DataManagerError? = nil
            
            manager.weatherDataAt(
                latitude: 52,
                longitude: 100,
                completion: {
                    (_, e) in
                    error = e
            })
            
            XCTAssertEqual(error, WeatherDataManager.DataManagerError.invalidResponse)
        }
        
        func test_weatherDataAt_handle_response_decode() {
            session.responseHeader = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)
            
            let data = """
    {
        "longitude" : 100,
        "latitude" : 52,
        "currently" : {
            "temperature" : 23,
            "humidity" : 0.91,
            "icon" : "snow",
            "time" : 1507180335,
            "summary" : "Light Snow"
        }
    }
    """.data(using: .utf8)!
            session.responseData = data
            
            var decoded: WeatherData? = nil
            manager.weatherDataAt(
                latitude: 52,
                longitude: 100,
                completion: {
                    (d, _) in
                    decoded = d
            })
            
            let expected = WeatherData(
                latitude: 52,
                longitude: 100,
                currently: WeatherData.CurrentWeather(
                    time: Date(timeIntervalSince1970: 1507180335),
                    summary: "Light Snow",
                    icon: "snow",
                    temperature: 23,
                    humidity: 0.91))
            
            XCTAssertEqual(decoded!, expected)
        }
}
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

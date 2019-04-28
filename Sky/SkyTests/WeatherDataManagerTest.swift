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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_weatherDataAt_starts_the_session() {
        let session = MockURLSession()
        let dataTask = MockURLSessionDataTask()
        session.sessionDataTask = dataTask
        
        let url = URL(string: "https://darksky.net")!
        let manager = WeatherDataManager(baseURL: url, urlSession: session)
        
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
        XCTAssertNil(data)
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

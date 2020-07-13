//
//  BasicWeatherAppTests.swift
//  BasicWeatherAppTests
//
//  Created by Fedosov Sergey on 10.07.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import XCTest
@testable import BasicWeatherApp

class BasicWeatherAppTests: XCTestCase {

    var mainVC = MainViewController()
    var weatherAPI = WeatherAPI()
    var detailsVC = DetailsViewController()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: - Positive Cases
    
    
    func testNoData() {
        
     weatherAPI.weatherURL = ""
        weatherAPI.getWeatherData()
        XCTAssertThrowsError(weatherAPI.parseJSON(<#T##weatherData: Data##Data#>))
        xctass
    }
    
    func testDetails_labelTextStructure() {
        detailsVC.city = City(name: "Cork", temp: 0.0)
        detailsVC.setupUI()
        
        XCTAssert(detailsVC.weatherLabel.text == "The weather in Cork is 0.0℃")
    }
    

    func testDetails_labelErrorMessage() {
        detailsVC.city = nil
        detailsVC.setupUI()
        
        XCTAssert(detailsVC.weatherLabel.text == "Something went wrong^^'")
    }

}

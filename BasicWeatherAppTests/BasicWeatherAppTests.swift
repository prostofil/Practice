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

    var detailsVC = DetailsViewController()
        
    func testDetails_labelTextStructure() {
        detailsVC.city = City(name: "Cork", temp: 0.0)
        detailsVC.setupLabel()
        
        XCTAssert(detailsVC.weatherLabel.text == "The weather in Cork is 0.0℃")
    }
    

    func testDetails_labelErrorMessage() {
        detailsVC.city = nil
        detailsVC.setupLabel()
        
        XCTAssert(detailsVC.weatherLabel.text == "Something went wrong^^'")
    }

}

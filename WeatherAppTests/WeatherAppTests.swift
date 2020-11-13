//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Fedosov Sergey on 08.11.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import XCTest
@testable import WeatherApp
import RxSwift
import RxFeedback
import RxCocoa

class CoreDataMock: DataManagerProtocol {
    
    var cities: [WeatherModel]
    
    init(cities:[WeatherModel]) {
        self.cities = cities
    }
    
    func saveOrUpdate(cities: [WeatherModel]) {
    }
    
    func getCitiesFromCD() -> [WeatherModel]? {
        return cities
    }
}

class WeatherAppTests: XCTestCase {
    
    let coreData = CoreDataMock(cities: [WeatherModel(cityName: "London", temperature: 12)])
    let url = "https://www.tutu.ru"
    lazy var networkManager = NetworkManager(coreData: coreData, url: url)
    let bag = DisposeBag()

    
    func testCoreDataWhenNoNetwork() {
        let exp1 = self.expectation(description: "WeatherAppTests")
        
        self.networkManager.getData().subscribe(onSuccess: {(result) in
            XCTAssertEqual(result, [WeatherModel(cityName: "London", temperature: 12)])
            exp1.fulfill()
        })
        { (error) in
            print("error")
        }.disposed(by: self.bag)
        self.waitForExpectations(timeout: 10)
    }
}






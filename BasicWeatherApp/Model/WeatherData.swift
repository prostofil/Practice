//
//  WeatherData.swift
//  BasicWeatherApp
//
//  Created by Fedosov Sergey on 11.07.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    let list: [CityModel]
}

struct CityModel: Decodable {
    
    let name: String
    let main: Main
}

struct Main: Decodable {
    
    let temp: Double
}




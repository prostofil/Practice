//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 26.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//


import Foundation

struct WeatherData: Decodable {
    
    let list: [City]
    
}

struct City: Decodable {
    let name: String
    let main: Main
}

struct Main: Decodable {
    let temp: Double
}

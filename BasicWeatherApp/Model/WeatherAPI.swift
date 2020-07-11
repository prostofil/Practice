//
//  WeatherAPI.swift
//  BasicWeatherApp
//
//  Created by Fedosov Sergey on 11.07.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import Foundation

// here we get the data from server
struct WeatherAPI {
    
    var delegate: WeatherAPIDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/find?lat=55.99&lon=-2.54&cnt=5&units=metric&appid=bbead9bb4e81a9d4c95a833d92f3c02e"
    
    func getWeatherData() {
        guard let url = URL(string: weatherURL) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                self.parseJSON(data)
            }
        }
    }
    
    func parseJSON(_ weatherData: Data) -> [City] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(weatherData.self from: weatherData)
        }
    }
}

protocol WeatherAPIDelegate {
    func didGetWeatherData()
}

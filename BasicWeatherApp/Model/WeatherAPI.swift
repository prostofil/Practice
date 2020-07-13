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
    
    var weatherURL = "https://api.openweathermap.org/data/2.5/find?lat=55.99&lon=-2.54&cnt=5&units=metric&appid=bbead9bb4e81a9d4c95a833d92f3c02e"
    
    func getWeatherData() {
        guard let url = URL(string: weatherURL) else {return}
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let safeData = data {
                        if let cities = self.parseJSON(safeData){
                            self.delegate?.didGetWeatherData(self, for: cities)
                        }
                    }
                } else {
                    print(error?.localizedDescription ?? "Error getting data.")
                    self.delegate?.didFailToGetData()
                }
            }
            task.resume()
    }
    
    
    func parseJSON(_ weatherData: Data) -> [City]? {
        print("Start parsing JSON")
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            var cities: [City] = []
            
            for n in 0..<decodedData.list.count {
                cities.append(City(name: decodedData.list[n].name,
                                   temp: decodedData.list[n].main.temp))
            }
            print("JSON decoded")
            return cities
        } catch {
            print("Parsing failed")
            delegate?.didFailToGetData()
            return nil
        }
    }
}

protocol WeatherAPIDelegate {
    func didGetWeatherData(_ weaherAPI: WeatherAPI, for cities: [City])
    func didFailToGetData()
}

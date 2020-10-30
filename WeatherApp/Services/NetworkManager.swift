//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 26.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//


import Foundation
import RxSwift
import CoreData
import UIKit

struct NetworkManager {
    
    private let coreData = CoreDataManager()
    
    var weatherURL = "https://api.openweathermap.org/data/2.5/find?lat=55.99&lon=-2.54&cnt=5&units=metric&appid=bbead9bb4e81a9d4c95a833d92f3c02e"
    
    func getData(string: String) -> Single<[WeatherModel]?> {
        return Single.create { observer in
            if let url = URL(string: self.weatherURL) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error == nil {
                        if let safeData = data {
                            if let weather = self.parseJSON(safeData){
                                observer(.success(weather))
                            }
                        }
                    }
                    else if let weather = self.coreData.getCitiesFromCD() {
                        observer(.success(weather))
                    }
                    else {
                        print("Error getting data")
                        return
                    }
                }
                task.resume()
            }
            return Disposables.create()
        }
    }
    
    
    
    func parseJSON(_ weatherData: Data) -> [WeatherModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            var cities: [WeatherModel] = []
            
            for n in 0..<decodedData.list.count {
                cities.append(WeatherModel(cityName: decodedData.list[n].name,
                                           temperature: decodedData.list[n].main.temp))
            }
            
            coreData.saveOrUpdate(cities: cities)
            return cities
            
        } catch {
            print("Error getting data")
            
            return nil
        }
    }
}



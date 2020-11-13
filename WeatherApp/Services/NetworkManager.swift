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

protocol NetworkProtocol {
    var weatherURL: String { get }
    func getData() -> Single<[WeatherModel]?>
}

struct NetworkManager: NetworkProtocol {
    
    let coreData: DataManagerProtocol
    let weatherURL: String
    
    init(coreData: DataManagerProtocol, url: String) {
        self.coreData = coreData
        self.weatherURL = url
    }
    
    func getData() -> Single<[WeatherModel]?> {
        return Single.create { observer in
            if let url = URL(string: self.weatherURL) {
                print("first if let url")
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error == nil {
                        print("if error nil")
                        if let safeData = data {
                            print(safeData)
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
        print("parse JSON")
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            var cities: [WeatherModel] = []
            
            for n in 0..<decodedData.list.count {
                cities.append(WeatherModel(cityName: decodedData.list[n].name,
                                           temperature: decodedData.list[n].main.temp))
            }
            print("now core data save should run")
            coreData.saveOrUpdate(cities: cities)
            return cities
            
        } catch {
            print("Error decoding data")
            if let cities = coreData.getCitiesFromCD() {
                return cities
            } else {
                print("Error getting data from CoreData")
            }
            return nil
        }
    }
}

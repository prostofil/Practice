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
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var coreData = CoreDataManager()
    
    
    var weatherURL = "https://api.openweathermap.org/data/2.5/find?lat=55.99&lon=-2.54&cnt=5&units=metric&appid=bbead9bb4e81a9d4c95a833d92f3c02e"
    // в идеале возвращать не этот сингл, а Single<Result<[WeatherModel],WeatherError>>
    
    
    func getData(string: String) -> Single<[WeatherModel]?> {
        print("start getting data")
        return Single.create { observer in
            if let url = URL(string: self.weatherURL) {
                let session = URLSession(configuration: .default)
                print("set a task")
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error == nil {
                        print("assign data")
                        if let safeData = data {
                            if let weather = self.parseJSON(safeData){
                                observer(.success(weather))
                            }
//                            else if let weather = self.coreData.getCitiesFromCD()  {
//                                observer(.success(weather))
//                            }
                        }
                    } else if let weather = self.coreData.getCitiesFromCD() {
                        observer(.success(weather))
                    } else {
                       print("Error getting data")
                       
//                        self.coreData.fetchCities()
//                        print(self.coreData.cityModels)
                      
                        
                        return
                    }
                }
                task.resume()
            }
            return Disposables.create()
        }
    }
    
    
    
     func parseJSON(_ weatherData: Data) -> [WeatherModel]? {
        print("start parsing")
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            var cities: [WeatherModel] = []
            
    
            for n in 0..<decodedData.list.count {
                cities.append(WeatherModel(cityName: decodedData.list[n].name,
                                           temperature: decodedData.list[n].main.temp))
            }
            
            print("JSON Parsed")
            //coreData.createCities(cities: cities)
//            coreData.fetchCities()
           
            coreData.saveOrUpdate(cities: cities)
             print(coreData.cityModels)
                // save data on disk
                // check for duplicates
//            coreData.createCities(cities: cities)
//            print(coreData.cityModels)
//            print(coreData.context)
            //createCities(cities: cities)
            
            return cities
            
        } catch {
            print("Error getting data")
            
            print("trying to get data from disk")
            
            return nil
        }
    }
    
    
    
//    mutating func createCities(cities: [WeatherModel]) {
//           print("creating cities")
//           for n in 0..<cities.count {
//
//            var cityModels: [CityModelCD] = []
//
//               let city = NSEntityDescription.insertNewObject(forEntityName: "CityModelCD", into: context) as! CityModelCD
//               city.name = cities[n].cityName
//               city.temp = cities[n].temperature
//               cityModels.append(city)
//             saveContext()
//           }
//       }
//
//    func saveContext() {
//        do {
//            try context.save()
//            print("saving context")
//
//        } catch {
//            print("Failed to save context: \(error)")
//        }
//    }
}



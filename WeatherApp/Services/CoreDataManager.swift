//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 28.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol DataManagerProtocol {
    
    func saveOrUpdate(cities: [WeatherModel])
    func getCitiesFromCD() -> [WeatherModel]?
}

class CoreDataManager: DataManagerProtocol {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<CityModelCD>(entityName: "CityModelCD")
    
    func saveOrUpdate(cities: [WeatherModel]) {
        print("original CD save or update")
        var cityModels: [CityModelCD] = []
        do {
            cityModels = try context.fetch(request)
        } catch {
            print("Error getting data from CoreData")
        }
        if cityModels.count > 0 {
            for n in 0..<cityModels.count {
                cityModels[n].temp = cities[n].temperature
            }
        } else {
            for n in 0..<cities.count {
                let city = NSEntityDescription
                    .insertNewObject(forEntityName: "CityModelCD", into: context) as! CityModelCD
                city.name = cities[n].cityName
                city.temp = cities[n].temperature
                cityModels.append(city)
                saveContext()
            }
        }
    }
    
    func getCitiesFromCD() -> [WeatherModel]? {
        print("Origianl CD")
        var cityModels: [CityModelCD] = []
        var cities: [WeatherModel] = []
        do {
            cityModels = try context.fetch(request)
            guard cityModels.count > 0 else {
                print("No data to load")
                return []
            }
            print("found data on disk, converting to model")
            for n in 0..<cityModels.count {
                guard let name = cityModels[n].name else {return []}
                let temp = cityModels[n].temp
                cities.append(WeatherModel(cityName: name, temperature: temp))
            }
        }
        catch {
            print("Error. Please, check network and restart the app")
        }
        return cities
    }
    
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

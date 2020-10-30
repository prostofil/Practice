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

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var cityModels: [CityModelCD] = []
   let request = NSFetchRequest<CityModelCD>(entityName: "CityModelCD")
    
     func createCities(cities: [WeatherModel]) {
          print("creating cities")
          for n in 0..<cities.count {
              let city = NSEntityDescription.insertNewObject(forEntityName: "CityModelCD", into: context) as! CityModelCD
              city.name = cities[n].cityName
              city.temp = cities[n].temperature
              cityModels.append(city)
            saveContext()
          }
      }
    
    func saveOrUpdate(cities: [WeatherModel]) {
        
        
        
        fetchCities()
        if cityModels.count > 0 {
            updateCities(cities: cities)
            print("cities updated")
        } else {
            createCities(cities: cities)
            print("cities created")
        }
        
        
    }
    
    
    func updateCities(cities: [WeatherModel]) {
           print("updating cities")
           for n in 0..<cityModels.count {
               cityModels[n].temp = cities[n].temperature
           }
       }
    
    
    func getCitiesFromCD() -> [WeatherModel]? {
        var cities: [WeatherModel] = []
        do {
                print(" try fetching")
                cityModels = try context.fetch(request)
                guard cityModels.count > 0 else {
                    return []
                }
               
                
                for n in 0..<cityModels.count {
                    guard let name = cityModels[n].name else {return []}
                    let temp = cityModels[n].temp
                    cities.append(WeatherModel(cityName: name, temperature: temp))
                }
            
                print("mapped fetched data from dsik to models")
                print(cities)
                
            } catch {
                print("Error. Please, check network and restart the app")
            }
        return cities
        }
        
        
    
    
   func fetchCities()  {
          do {
              print(" try fetching")
              cityModels = try context.fetch(request)
//              guard cityModels.count > 0 else {
////                  navigationItem.title = "check network and restart the app"
//                  return
//              }
              print("fetched models")
              print(cityModels)
              
//              for n in 0..<cityModels.count {
//                  guard let name = cityModels[n].name else {return}
//                  let temp = cityModels[n].temp
//                  cities.append(WeatherModel(cityName: name, temperature: temp))
//              }
             // print("mapped fetched data from dsik to models")
              
          } catch {
              print("Error. Please, check network and restart the app")
          }
      }

    
    
    
    
    
//    let persistentContainer = NSPersistentContainer(name: "CityModelCoreData")
//
//    persistentContainer.loadPersistentStores { storeDescription, error in
//        if let error = error {
//            assertionFailure(error.localizedDescription)
//        }
//        print("Core Data stack has been initialized with description: \(storeDescription)")
//    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CityModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                        assertionFailure(error.localizedDescription)
                    }
            print("Core Data stack has been initialized with description: \(storeDescription)")
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
//    mutating func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
    func saveContext() {
           do {
               try context.save()
               print("saving context")
               
           } catch {
               print("Failed to save context: \(error)")
           }
       }
}

//
//  MainViewController.swift
//  BasicWeatherApp
//
//  Created by Fedosov Sergey on 10.07.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {
    
    var cities: [City] = []
    var cityModels: [CityModel] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<CityModel>(entityName: "CityModel")
    
    var weatherAPI = WeatherAPI()
    var loading = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Choose a city"
        weatherAPI.delegate = self
        weatherAPI.getWeatherData()
        
    }
    
    // MARK: - TableView Setup
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading {
            return 1
        } else {
            return cities.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if loading {
            cell.textLabel?.text = "Loading..."
        } else {
            cell.textLabel?.text = cities[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = DetailsViewController()
        detailsVC.city = cities[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: - Core Data
    
    func createNew(_ cities: [City]) {
        for n in 0..<cities.count {
            let cityModel = NSEntityDescription.insertNewObject(forEntityName: "CityModel", into: context) as! CityModel
            cityModel.name = cities[n].name
            cityModel.temp = cities[n].temp
            cityModels.append(cityModel)
        }
    }
    
    func updateExisting(_ cities: [City]) {
        for n in 0..<cityModels.count {
            cityModels[n].temp = cities[n].temp
        }
    }
    
    func saveOrUpdate(_ cities: [City]) {
        
        do {
            cityModels = try context.fetch(request)
        } catch {
            print("No data found")
        }
        
        if cityModels.count > 0 {
            updateExisting(cities)
        } else {
            createNew(cities)
        }
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func fetchCitiesFromDisk()  {
        do {
            cityModels = try context.fetch(request)
            guard cityModels.count > 0 else {
                navigationItem.title = "check network and restart the app"
                return
            }
            
            for n in 0..<cityModels.count {
                guard let name = cityModels[n].name else {return}
                let temp = cityModels[n].temp
                cities.append(City(name: name, temp: temp))
            }
        } catch {
            print("Error fetching")
        }
    }
}

// MARK: - Delegate Functions

extension MainViewController: WeatherAPIDelegate {
    
    func didGetWeatherData(_ weaherAPI: WeatherAPI, for cities: [City]) {
        DispatchQueue.main.async {
            self.loading = false
            self.cities = cities
            self.tableView.reloadData()
            self.saveOrUpdate(cities)
        }
    }
    
    func didFailToGetData() {
        DispatchQueue.main.async {
            self.fetchCitiesFromDisk()
            self.loading = false
            self.tableView.reloadData()
        }
    }
}

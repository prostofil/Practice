//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 26.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class MainScreenViewController: UIViewController {
    
    var tableView = UITableView()
    var cities: [WeatherModel] = []
    var didSelectIndex = PublishSubject<IndexPath>()
    private let bag = DisposeBag()
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
                    
           setupTableView()
       }
       
           
           func setupTableView() {
               print("setup MainVC")
               title = "Choose a city"
               
               view.addSubview(tableView)
               
               tableView.frame = self.view.bounds
               tableView.rowHeight = 60
               
               tableView.delegate = self
               tableView.dataSource = self
           }
    
    
    
}

extension  MainScreenViewController:  UITableViewDataSource,  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return cities.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
            cell.textLabel?.text = cities[indexPath.row].cityName
        
        return cell
    }
    
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectIndex.onNext(indexPath)
       }
}

extension MainScreenViewController {
    
    func subscribe(to stateStore: StateStore<WeatherAppState>) {
        print("MainScreenViewController.subscribe()")
        
        stateStore.stateBus.map { $0.cities}
            .distinctUntilChanged()
            .drive(onNext:
                {
                    self.cities = $0
                    self.tableView.reloadData()
            })
            .disposed(by: bag)
        
        didSelectIndex.map { index in
            .didSelectCity(atIndex: index.row)
        }.bind(to: stateStore.eventBus)
        .disposed(by: bag)
    }
    
}

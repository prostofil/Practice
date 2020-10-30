//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 26.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import UIKit
import RxSwift

class DetailsViewController: UIViewController {
    
    
    var label = UILabel()
    var temp: String = ""
    var city: String = ""
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        label.frame = CGRect(x: 100, y: 100, width: 400, height: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.center = self.view.center
        
        label.textAlignment = .center
        //self.label.text =  "The weather in \(city) is \(temp)"
        
        view.addSubview(label)
        
    }
    
    
    
}

//event нажатие
// изменения в системе системе

extension DetailsViewController {
    func subscribe(to stateStore: StateStore<WeatherAppState>) {
        print("DetailsVC.subscribe to stateStore")
        stateStore.stateBus.map {
            $0.selectedCity
        }
            .drive(onNext:
            {city in
                guard let city = city else {return}
                self.label.text = "The weather in \(city.cityName) is \(city.temperature)"
               
        })
            .disposed(by: bag)
    }
}

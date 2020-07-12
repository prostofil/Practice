//
//  DetailsViewController.swift
//  BasicWeatherApp
//
//  Created by Fedosov Sergey on 10.07.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var weatherLabel = UILabel()
    var text: String?
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
      
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        guard let city = city else {
            weatherLabel.text = "Something went wrong^^'"
            return
        }
         
        weatherLabel.text = "The weather in \(city.name)is \(city.temp)℃"
        
        weatherLabel.frame = CGRect(x: 0, y: 0, width: 350, height: 50)

              weatherLabel.textAlignment = .center
              weatherLabel.center = self.view.center
              view.addSubview(weatherLabel)
    }
  

}

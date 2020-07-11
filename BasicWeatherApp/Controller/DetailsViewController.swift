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
    // надо поумать, можно передать модель города и вставить и в лейбл, а можно создать две переменные для имени и температуры и передавать их
    //первый вариант чуть сложнее, но более расширяем, на случай если параметров будет много, а не два как сейчас
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .systemBackground
        weatherLabel = UILabel(frame: UIScreen.main.bounds)
        weatherLabel.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
        
        weatherLabel.text = "The weather is fine \(text)!"
        weatherLabel.textAlignment = .center
        weatherLabel.center = self.view.center
        view.addSubview(weatherLabel)
    }
    
    func setupUI() {
        
    }
  

}

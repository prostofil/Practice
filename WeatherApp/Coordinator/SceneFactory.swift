//
//  SceneFactory.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 26.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//


import UIKit

final class SceneFactory {
   
    
    var stateStore: StateStore<WeatherAppState>!
    
    
    func create(scene: Scene) -> UIViewController {
        switch scene {
        case .detailsScreen:
            let vc = DetailsViewController()
          
            vc.subscribe(to: stateStore)
            return vc
        case .mainScreen:
            let vc = MainScreenViewController()
            
              vc.subscribe(to: stateStore)
              return vc
        }
    }
}

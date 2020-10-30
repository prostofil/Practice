//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 25.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var stateStore: StateStore<WeatherAppState>!
    var window: UIWindow?
    private let bag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainVC = MainScreenViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let sceneFactory = SceneFactory()
        
        
        stateStore = StateStore(initial: WeatherAppState(),
                                sideEffects: WeatherAppSideEffects.init(
                                    coordinator: CoordinatorImpl(
                                        navigator: Navigator(push: {
                                            navigationController.pushViewController($0, animated: true)
                                            return .just(())
                                        }),
                                        sceneFactory: sceneFactory),
                                    networkManager: NetworkManager(),
                                    state: WeatherAppState()).effects )
        
        sceneFactory.stateStore = stateStore
        stateStore.run()
        
        mainVC.subscribe(to: stateStore)
        
        return true
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CityModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        })
        return container
    }()
    
    
    
    
    
    
    
    
}


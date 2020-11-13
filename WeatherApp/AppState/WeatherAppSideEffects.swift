//
//  WeatherAppSideEffects.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 26.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import Foundation
import RxFeedback
import RxSwift


typealias WeatherSideEffect = SideEffect<WeatherAppState, WeatherAppState.Event>

struct WeatherAppSideEffects {
    
    private let coordinator: Coordinator
    private let networkManager: NetworkProtocol
   // private var url: String
   
    init(coordinator: Coordinator, networkManager: NetworkProtocol, state: WeatherAppState) {
        self.coordinator = coordinator
        self.networkManager = networkManager
       // self.url = networkManager.weatherURL
    }
    
    
    var effects: [WeatherSideEffect] {
        let effects: [WeatherSideEffect] = [
            react(query: { $0.shouldLoadData }, effects: loadData),
            react(query: { $0.shouldOpenDetails}, effects: openDetails)]
        
        return effects
    }
    
    var loadData: (Bool) -> Observable<WeatherAppState.Event> {
        
        return {_ in
            return self.networkManager.getData()
                .asObservable()
                .map{ .didLoadData($0)}
        }
    }
    
    var openDetails: (Bool) -> Observable<WeatherAppState.Event> {
        
        return {shoulOpen in
            shoulOpen
                ? self.coordinator.push(scene: .detailsScreen)
                    .asObservable()
                    .map {.didOpenDetails}
                : .empty()
        }
    }
}




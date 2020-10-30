//
//  WeatherAppState.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 25.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.


import Foundation
import RxSwift
import RxCocoa


struct WeatherAppState: State {
    
    private(set) var cities: [WeatherModel] = []
    private(set) var selectedCity: WeatherModel?
    private(set) var shouldOpenDetails = false
    private(set) var shouldLoadData = true
    private(set) var didLoadData = false
    
}

// MARK: - Event
extension WeatherAppState {
    enum Event {
        case didLoadData([WeatherModel]?)
        case didSelectCity(atIndex: Int)
        case didOpenDetails
    }
}

// MARK: - Reduce
extension WeatherAppState {
    static func reduce(state: WeatherAppState, event: Event) -> WeatherAppState {
        var state = state
        state.reduce(with: event)
        return state
    }
    
    mutating func reduce(with event: Event) {
        switch event {
            
        case .didLoadData(let cities):
            self.shouldLoadData = false
            self.didLoadData = true
            self.cities = cities ?? []
            
        case .didSelectCity(let index):
            self.selectedCity = cities[index]
            shouldOpenDetails = true
            
        case .didOpenDetails:
            self.shouldOpenDetails = false
        }
    }
}

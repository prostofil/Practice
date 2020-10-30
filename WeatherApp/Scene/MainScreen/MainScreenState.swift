////
////  MainScreenState.swift
////  WeatherApp
////
////  Created by Fedosov Sergey on 25.10.2020.
////  Copyright © 2020 Fedosov Sergey. All rights reserved.
////
//
//import Foundation
//
//struct MainScreenState {
//    
//        private(set) var shouldOpen = false
//       private(set) var cities: [WeatherModel]?
//    
//}
//
//
// // MARK: - Event
//extension MainScreenState {
//
//        enum Event {
//            case open
//            case opened
//        }
//}
//
//
//// MARK: - Reduce
//extension MainScreenState {
//    mutating func reduce(event: Event) {
//        self = .reduce(state: self, event: event)
//    }
//
//    static func reduce(state: MainScreenState, event: Event) -> MainScreenState {
//        var state = state
//        switch event {
//        case .open:
//             state.shouldOpen = true
//        case .opened:
//            state.shouldOpen = false
//
//        }
//        return state
//    }
//}
//
//extension MainScreenState {
//    var queryOpen: Void? {
//        print("queryOpen triggers shouldOpen. Now \(shouldOpen)")
//        return shouldOpen ? () : nil
//    }
//   
//    var queryShouldLoadWeather: Void? {
//        print("goes to the loading service for the data")
//        return nil
//    }
//}

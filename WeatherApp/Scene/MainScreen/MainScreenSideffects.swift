//
//  MainScreenSideffects.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 26.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

    
    import RxFeedback
    import RxSwift

    struct MainScreenSideEffects {
        private let coordinator: Coordinator

        init(coordinator: Coordinator) {
            self.coordinator = coordinator
        }
    }
//
//    extension MainScreenSideEffects {
//        var effects: [WeatherSideEffect] {
//            return [
//                react(query: { $0.mainState.queryOpen }, effects: openScene),
//            ]
//        }
//
////        var openScene: () -> Observable<WeatherAppState.Event> {
////            return {
////                self.coordinator
////                    .push(scene: .mainScreen)
////                    .asObservable()
////                    .map { .mainScreen(.open) }
////            }
//        }
//
//
//}





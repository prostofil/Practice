//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 26.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//


import RxSwift

protocol Coordinator {
    func push(scene: Scene) -> Single<Void>
}

class CoordinatorImpl: Coordinator {
    private let navigator: Navigator
    private let sceneFactory: SceneFactory

    init(navigator: Navigator, sceneFactory: SceneFactory) {
        self.navigator = navigator
        self.sceneFactory = sceneFactory
    }

    func push(scene: Scene) -> Single<Void> {
        navigator.push(sceneFactory.create(scene: scene))
    }
}

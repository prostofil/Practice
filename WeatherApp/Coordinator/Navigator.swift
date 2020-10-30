//
//  Navigator.swift
//  WeatherApp
//
//  Created by Fedosov Sergey on 26.10.2020.
//  Copyright © 2020 Fedosov Sergey. All rights reserved.
//

import RxSwift

public struct Navigator {
    let push: (UIViewController) -> Single<Void>
   
    public init(push: @escaping (UIViewController) -> Single<Void>) {
        self.push = push
    }
}

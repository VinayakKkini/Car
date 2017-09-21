//
//  FetchCar.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/22/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import Foundation
import UIKit


/// Protocol to fetch the cars from the server
protocol FetchCar: class {
    var cars: [Car]? { get set }
}

extension FetchCar {
    
    /// Fetches the car from the server
    ///
    /// - Parameter controllerView: Any class that conforms to DisplayHUD
    func fetchCars(on controllerView: DisplayHUD?) {
        controllerView?.showHUD(withStatus: "Loading")
        CarListService.shared.fetch { [weak self] (error, cars) in
            guard error == nil else {
                controllerView?.dismissHUD()
                self?.cars = nil
                return
            }
            self?.cars = cars
            controllerView?.dismissHUD()
        }
    }
}

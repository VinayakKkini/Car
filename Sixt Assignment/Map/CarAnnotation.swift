//
//  Car + MKAnnotation.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/21/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import Foundation
import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    private let car: Car
    
    init(with car: Car) {
        self.car = car
    }
    
    var coordinate: CLLocationCoordinate2D {
        guard let location = car.location else {
            return CLLocationCoordinate2D()
        }
        return location
    }
    
    var title: String? {
        return car.modelName
    }
    
    var subtitle: String? {
        return car.licensePlate
    } 
}


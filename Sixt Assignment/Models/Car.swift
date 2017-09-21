//
//  Car.swift
//  Sixt Assignment
//
//  Created by Vinayak Kini on 9/20/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import Foundation
import CoreLocation


/*
 // Expected response
 """
 {"id": "WMWSU31050T077262","modelIdentifier": "mini","modelName": "MINI","name": "Scarlett","make": "BMW","group": "MINI","color": "midnight_black","series": "MINI","fuelType": "P","fuelLevel": 0.98,"transmission": "M","licensePlate": "M-VO0130","latitude": 48.162771,"longitude": 11.592978,"innerCleanliness": "CLEAN"}
 """
 */


/// Model to represent the car model.
struct Car: Codable {
    
    var id: String?
    var modelIdentifier: String?
    var modelName: String?
    var name: String?
    var make: String?
    var group: String?
    var color: String?
    var series: String?
    var fuelType = FuelType.petrol
    var fuelLevel: Float = 0
    var transmission = TransmissionMode.automatic
    var licensePlate: String?
    var innerCleanliness = Cleanliness.veryClean
    
    private var latitude: CLLocationDegrees = 0
    private var longitude: CLLocationDegrees = 0
}

extension Car {
    
    var carImageURL: URL? {
        guard let modelID = modelIdentifier, let color = color else {
            return nil
        }
        
        let urlString = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(modelID)/\(color)/2x/car.png"
        
        return URL(string: urlString)
    }
    
    var location: CLLocationCoordinate2D? {
        return CLLocationCoordinate2D(latitude:latitude, longitude: longitude)
    }
}



/// Enum for identifying the Type of fuel used by the car
enum FuelType: String, Codable {
    case diesel = "D"
    case petrol = "P"
    case electric = "E"
    
    /// Title for display purposes
    var displayTitle: String {
        switch self {
        case .diesel:
            return "Diesel"
        case .petrol:
            return "Petrol"
        case .electric:
            return "Electric"
        }
    }
}


/// Enum to identify the mode of tranmission of the vehicle
enum TransmissionMode: String, Codable {
    case manual = "M"
    case automatic = "A"
    
    /// To be used for display purposes in the UI
    var displayTitle: String {
        switch self {
        case .manual:
            return "Manual"
        case .automatic:
            return "Automatic"
        }
    }
}


/// Enum to identify the cleanliness of the car
enum Cleanliness: String, Codable {
    case clean = "CLEAN"
    case veryClean = "VERY_CLEAN"
    case regular = "REGULAR"
    
    /// Can be used for display purposes
    var displayTitle: String {
        switch self {
        case .clean:
            return "Clean"
        case .veryClean:
            return "Very Clean"
        case .regular:
            return "Regular"
        }
    }
}


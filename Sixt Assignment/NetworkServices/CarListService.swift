//
//  Networking.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/20/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import Foundation
import Alamofire

class CarListService: NSObject {
    
    // URL for fetching the available cars
    private let carServiceURLString = "http://www.codetalk.de/cars.json"
    
    // Shared instance of CarListService
    static let shared = CarListService()
    
    
    /// Fetches the available cars from the server
    ///
    /// - Parameter completion: closure to identify error and available cars
    func fetch(completion: @escaping (_ error: Error?, _ cars: [Car]?) -> Void) {
        Alamofire.request(self, method: .get).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                completion(nil, nil)
                return
            }

            let carList = try? JSONDecoder().decode(Array<Car>.self, from: data)
            completion(nil, carList)
        }
        
    }
}


// uses the Alamofire protocol
extension CarListService: URLConvertible {
    /// Constructs the URL
    public func asURL() throws -> URL {
        return try carServiceURLString.asURL()
    }
}

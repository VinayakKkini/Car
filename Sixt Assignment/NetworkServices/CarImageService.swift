//
//  CarImageFetch.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/21/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import Foundation
import Alamofire

class CarImageService {
    
    // Shared instance of CarImageService
    static let shared = CarImageService()
    
    // Used to save the fetched images. The best way would be to use the caching alorithms.
    var localCache = [String: UIImage]()
    
    
    /// Fectches images from the server
    ///
    /// - Parameters:
    ///   - imageURL: `URL` of the image
    ///   - completion: closure containing the image
    func fetch(imageURL: URL,completion: @escaping (_ image: UIImage?) -> Void) {
        
        guard nil == localCache[imageURL.absoluteString] else {
            // already cached. call completion block with the image
            let carImage = localCache[imageURL.absoluteString]
            completion(carImage)
            return
        }
        
        //fetch the image from server
        Alamofire.request(imageURL, method: .get).validate().responseData(completionHandler: { [weak self] (response) in
            
            guard response.result.isSuccess else {
                completion(nil)
                return
            }
            
            guard let data = response.data else {
                completion(nil)
                return
            }
            
            let carImage = UIImage(data: data)
            //cache the image
            self?.localCache[imageURL.absoluteString] = carImage
            completion(carImage)
            
        })
    }
}


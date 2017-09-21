//
//  CarListCell.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/21/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import UIKit

class CarListCell: UITableViewCell {
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var fuelType: UILabel!
    @IBOutlet weak var cleanliness: UILabel!
    @IBOutlet weak var transmission: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //set the placeholder image
        carImageView.image = #imageLiteral(resourceName: "car-placeholder")
    }
    
    override func prepareForReuse() {
        // clean up all resources
        carImageView.image = #imageLiteral(resourceName: "car-placeholder")
        owner.text = nil
        modelName.text = nil
        fuelType.text = nil
        cleanliness.text = nil
        transmission.text = nil
    }
    
    
    /// Configure the cell with `Car` object
    ///
    /// - Parameter car: object used to set up the cell
    func configure(with car: Car) {
        owner.attributedText = attributedString(with: Car.DisplayKeys.owner.rawValue, value: car.name ?? "")
        modelName.attributedText = attributedString(with: Car.DisplayKeys.modelName.rawValue, value: car.modelName  ?? "")
        fuelType.attributedText = attributedString(with: Car.DisplayKeys.fuelType.rawValue, value: car.fuelType.displayTitle)
        cleanliness.attributedText = attributedString(with: Car.DisplayKeys.cleanliness.rawValue, value: car.innerCleanliness.displayTitle)
        transmission.attributedText = attributedString(with: Car.DisplayKeys.transmission.rawValue, value: car.transmission.displayTitle)
        
        guard let imageURL = car.carImageURL else {
            carImageView.image = #imageLiteral(resourceName: "car-placeholder")
            return
        }
        
        // fetch the image from the server
        CarImageService.shared.fetch(imageURL: imageURL) { (image) in
            DispatchQueue.main.async { [weak self] in
                self?.carImageView.image = image ?? #imageLiteral(resourceName: "car-placeholder")
            }
        }
    }
}



extension CarListCell {
    
    /// Creates an attributted string by combining both title and values. Title will have bold font and
    /// value being regular weight.
    private func attributedString(with title: String, value: String) -> NSAttributedString {
        let attribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize:15), NSAttributedStringKey.foregroundColor: UIColor.black]
        let attributedTitle = NSMutableAttributedString(string: title, attributes: attribute)
        attributedTitle.append(NSAttributedString(string: ": \(value)"))
        return attributedTitle
    }
    
}

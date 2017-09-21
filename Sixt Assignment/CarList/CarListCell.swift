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
        carImageView.image = #imageLiteral(resourceName: "car-placeholder")
    }
    
    override func prepareForReuse() {
        carImageView.image = #imageLiteral(resourceName: "car-placeholder")
        owner.text = nil
        modelName.text = nil
        fuelType.text = nil
        cleanliness.text = nil
        transmission.text = nil
    }
    
    func configure(with car: Car) {
        owner.attributedText = attributedString(with: CarTitleKeys.owner.rawValue, value: car.name ?? "")
        modelName.attributedText = attributedString(with: CarTitleKeys.modelName.rawValue, value: car.modelName  ?? "")
        fuelType.attributedText = attributedString(with: CarTitleKeys.fuelType.rawValue, value: car.fuelType.displayTitle)
        cleanliness.attributedText = attributedString(with: CarTitleKeys.cleanliness.rawValue, value: car.innerCleanliness.displayTitle)
        transmission.attributedText = attributedString(with: CarTitleKeys.transmission.rawValue, value: car.transmission.displayTitle)
        
        guard let imageURL = car.carImageURL else {
            carImageView.image = #imageLiteral(resourceName: "car-placeholder")
            return
        }
        
        CarImageService.shared.fetch(imageURL: imageURL) { (image) in
            DispatchQueue.main.async { [weak self] in
                self?.carImageView.image = image ?? #imageLiteral(resourceName: "car-placeholder")
            }
        }
    }
}



extension CarListCell {
    
    private enum CarTitleKeys: String {
        case owner = "Owner"
        case modelName = "Model Name"
        case fuelType = "Fuel Type"
        case cleanliness = "Cleanliness"
        case transmission = "Transmission"
    }
    
    private func attributedString(with title: String, value: String) -> NSAttributedString {
        let attribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize:15), NSAttributedStringKey.foregroundColor: UIColor.black]
        let attributedTitle = NSMutableAttributedString(string: title, attributes: attribute)
        attributedTitle.append(NSAttributedString(string: ": \(value)"))
        return attributedTitle
    }
    
}

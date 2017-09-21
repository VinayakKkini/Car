//
//  MapViewController.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/21/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let viewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setup(with: self)
    }
}

extension MapViewController: DisplayHUD {
    
    func showHUD(withStatus status: String) {
        
        guard !(self.presentedViewController is ActivityViewController) else {
            return
        }
        
        let alert = ActivityViewController.instantiate()
        alert.message = status
        alert.modalPresentationStyle = .overCurrentContext
        alert.modalTransitionStyle = .crossDissolve
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismissHUD() {
        self.dismiss(animated: true, completion: nil)
    }
}

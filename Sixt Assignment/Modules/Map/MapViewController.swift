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

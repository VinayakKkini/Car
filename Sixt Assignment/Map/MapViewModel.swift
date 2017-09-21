//
//  MapViewModel.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/21/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import Foundation
import MapKit
import SVProgressHUD

class MapViewModel: NSObject {
    private let annotationIdentifier = "CarAnnotationIdentifier"
    private weak var controllerView: MapViewController?

    private var cars: [Car]? {
        didSet {
            addCarAnnotations()
        }
    }
    
    /// Sets up the viewmodel with the controller and other stuff
    ///
    /// - Parameter controller: Mapviewcontroller
    func setup(with controller: MapViewController) {
        controllerView = controller
        controllerView?.mapView.delegate = self
        centerMapOnLocation()
        fetchCars()
    }
    
    
    /// can be used to fetch cars from the server
    private func fetchCars() {
        SVProgressHUD.show()
        CarListService.shared.fetch { [weak self] (error, cars) in
            guard error == nil else {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
                self?.cars = nil
                return
            }
            SVProgressHUD.dismiss()
            self?.cars = cars
        }
    }
}


// MARK: - Location and Annotation related methods
private extension MapViewModel {
    
    
    /// Adds various car into map
    func addCarAnnotations() {
        guard let cars = cars else {
            return
        }
        for car in cars {
            controllerView?.mapView.addAnnotation(CarAnnotation(with: car))
        }
    }
    
    func centerMapOnLocation() {
        //ideally we should be using location manager and set it based on the user location
        //For now I have used one of the location from the json response
        let homePinLocation = CLLocation(latitude: 48.1351, longitude: 11.5820)
        
        // set the random radius
        let regionRadius: CLLocationDistance = 2500
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(homePinLocation.coordinate, regionRadius * 5.0, regionRadius * 5.0)
        controllerView?.mapView.setRegion(coordinateRegion, animated: true)
    }
}


// MARK: - MKMapViewDelegate Methods
extension MapViewModel: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CarAnnotation else {
            return nil
        }
        
        guard let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) else {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.image = #imageLiteral(resourceName: "car-pin")
            return view
        }
        dequeuedView.annotation = annotation
        dequeuedView.image = #imageLiteral(resourceName: "car-pin")
        return dequeuedView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //can handle tap of car annotations
    }
}

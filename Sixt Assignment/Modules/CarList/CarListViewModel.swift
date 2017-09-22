//
//  CarListViewModel.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/21/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import Foundation
import UIKit

class CarListViewModel: NSObject {
    private let cellIdentifier = "CarListCell"
    private weak var controllerView: CarListViewController?
    
    var cars: [Car]? {
        didSet {
            controllerView?.tableView.reloadData()
        }
    }
    
    /// sets up the view model 
    func setup(with controller: CarListViewController) {
        controllerView = controller
        controllerView?.tableView.delegate = self
        controllerView?.tableView.dataSource = self
        controllerView?.tableView.tableFooterView = UIView()
        fetchCars(on: controllerView?.parent)
    }
}

extension CarListViewModel: FetchCar {}

extension CarListViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //On selection can display the detail controller with all information about the car
    }
}

extension CarListViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CarListCell, let car = cars?[indexPath.row] else {
            return UITableViewCell()
        }

        cell.configure(with: car)
        return cell
    }
}

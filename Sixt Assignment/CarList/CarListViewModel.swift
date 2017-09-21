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
    
    private var cars: [Car]? {
        didSet {
            self.controllerView?.tableView.reloadData()
        }
    }
    
    weak var controllerView: CarListViewController?
    
    func setup(with controller: CarListViewController) {
        self.controllerView = controller
        self.controllerView?.tableView.delegate = self
        self.controllerView?.tableView.dataSource = self
        self.fetchCars()
    }
    
    func fetchCars() {
        self.controllerView?.showHUD(type: .loading)
        CarListService.shared.fetch { [weak self] (error, cars) in
            guard error == nil else {
                self?.controllerView?.showHUD(type: .error)
                self?.cars = nil
                return
            }
            
            self?.controllerView?.showHUD(type: .success)
            self?.cars = cars
        }
    }
}

extension CarListViewModel: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = self.cars?[indexPath.row]
        
    }
}

extension CarListViewModel: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? CarListCell, let car = self.cars?[indexPath.row] else {
            return UITableViewCell()
        }

        cell.configure(with: car)
        return cell
    }
}

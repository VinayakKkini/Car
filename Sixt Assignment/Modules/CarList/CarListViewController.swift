//
//  ViewController.swift
//  Sixt Assignment
//
//  Created by Vinayak Kini on 9/20/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let model = CarListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.setup(with: self)
    }
}

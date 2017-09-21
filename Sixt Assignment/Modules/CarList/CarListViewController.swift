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

extension CarListViewController: DisplayHUD {
    
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


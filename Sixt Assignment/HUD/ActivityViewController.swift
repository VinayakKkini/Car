//
//  ActivityViewController.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/22/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    var message: String?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = message
        containerView.layer.cornerRadius = 10.0;
        containerView.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func instantiate() -> ActivityViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ActivityViewController") as! ActivityViewController
    }
    
}

//
//  DisplayHUD.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/22/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import Foundation
import UIKit

protocol DisplayHUD {    
    func showHUD(withStatus status: String)
    func dismissHUD()
}


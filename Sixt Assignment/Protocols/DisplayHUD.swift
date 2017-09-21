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
    
    /// Used to display HUD with the required status
    ///
    /// - Parameter status: Status to be displayed on the HUD
    func showHUD(withStatus status: String)
    
    
    /// Dismisses the existing HUD
    func dismissHUD()
}


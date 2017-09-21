//
//  DisplayHUD.swift
//  Sixt
//
//  Created by Vinayak Kini on 9/21/17.
//  Copyright © 2017 Vinayak. All rights reserved.
//

import Foundation
import UIKit

enum HUDType {
    case loading
    case success
    case error
}

protocol DisplayHUD {
    func showHUD(type: HUDType)
    func hideHUD()
}

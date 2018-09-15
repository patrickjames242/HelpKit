//
//  NSLayoutConstraint.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit


extension NSLayoutConstraint{
    func activate(){
        isActive = true
    }
    func deactivate(){
        isActive = false
    }
}

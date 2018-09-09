//
//  UIGestureRecognizer.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension UIGestureRecognizer{
    
    open func stopInterferingWithTouchesInView(){
        cancelsTouchesInView = false
        delaysTouchesBegan = false
        delaysTouchesEnded = false
    }
    
    open func beginInterferingWithTouchesInView(){
        cancelsTouchesInView = true
        delaysTouchesBegan = true
        delaysTouchesEnded = true
    }
    
    open func cancelCurrentTouch(){
        isEnabled = false
        isEnabled = true
    }
}

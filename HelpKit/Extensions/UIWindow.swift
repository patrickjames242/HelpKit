//
//  UIWindow.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension UIWindow{
    
    
    
    open func dismissAllPresentedViewControllers(completion: (() -> Void)? = nil){
        if let root = rootViewController{
            root.dismissAllPresentedViewControllers(completion: completion)
        } else {completion?()}
        
    }
}

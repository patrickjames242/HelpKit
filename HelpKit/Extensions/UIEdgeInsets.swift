//
//  UIEdgeInsets.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension UIEdgeInsets{
    
    public init(allInsets: CGFloat){
        self.init(top: allInsets, left: allInsets, bottom: allInsets, right: allInsets)
    }
    
    public init(hktop: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0){
        
        self.init()
        self.top = hktop
        self.left = left
        self.bottom = bottom
        self.right = right
        
    }
    
    
}

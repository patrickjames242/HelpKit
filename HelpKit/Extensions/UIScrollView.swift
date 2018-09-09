//
//  UIScrollView.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension UIScrollView{
    open func scrollToTop(with animationBlock: ((() -> Void) -> Void)? = nil) -> Void {
        let action = {
            
            let offset = CGPoint(x: 0, y: -self.adjustedContentInset.top)
            self.setContentOffset(offset, animated: false)
            self.layoutIfNeeded()
        }
        if let block = animationBlock{
            block(action)
        } else {action()}
        
    }
}

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
        } else { action() }
    }
    
    open func scrollToBottom(animated: Bool = true) -> Void {
        layoutIfNeeded()
        
        let totalHeight = self.adjustedContentInset.top + self.contentSize.height + self.adjustedContentInset.bottom
        if totalHeight < self.bounds.height{return}
        let inset = totalHeight - self.frame.height
        let offset = CGPoint(x: 0, y: inset)
        self.setContentOffset(offset, animated: animated)        
    }
}

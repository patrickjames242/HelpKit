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
        
        let totalContentHeight = contentSize.height + adjustedContentInset.top + adjustedContentInset.bottom
        
        if bounds.height >= totalContentHeight{return}
        
        UIView.animate(withDuration: animated ? 0.2 : 0) {
            self.recursivelyScrollToBottomAndCheck()
        }
    }
    
    /// because in a self sizing table or collection view, I guess it's continuously setting the contentSize according to how tall the cells are, So when we scroll to the bottom we need to make sure the table or collection view isn't increasing the content size again.
    private func recursivelyScrollToBottomAndCheck(){
        
        let relevantContentHeight = contentSize.height + adjustedContentInset.bottom
        
        // it has to be rounded because apparently scroll views automatically rounds off any value we set the content size to
        let inset = (relevantContentHeight - bounds.height).rounded()
        if self.contentOffset.y != inset{
            let offset = CGPoint(x: 0, y: inset)
            
            contentOffset = offset
            
            self.layoutIfNeeded()
            recursivelyScrollToBottomAndCheck()
        }
    }
    
    
    
    
}

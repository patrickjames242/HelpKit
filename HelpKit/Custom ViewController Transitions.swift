//
//  Custom ViewController Transitions.swift
//  HelpKit
//
//  Created by Patrick Hanna on 8/6/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

open class HKInteractionController: NSObject, UIViewControllerInteractiveTransitioning{
    weak var context: UIViewControllerContextTransitioning?
    
    open func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.context = transitionContext
    }
    
    open func update(_ percentage: CGFloat){
        context?.updateInteractiveTransition(percentage)
    }
    open func cancelInteraction(){
        context?.cancelInteractiveTransition()
    }
    
    open func completeTransition(_ didComplete: Bool){
        context?.completeTransition(didComplete)
    }
    
    open func completeInteraction(){
        context?.finishInteractiveTransition()
    }
}

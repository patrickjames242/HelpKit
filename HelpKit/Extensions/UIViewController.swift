//
//  UIViewController.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension UIViewController{
    
    open func present(_ vc: UIViewController){
        self.present(vc, animated: true)
    }
    
    open func dismiss(){
        dismiss(animated: true)
    }
    
    private func getTopMostLevelParent(for vc: UIViewController) -> UIViewController{
        if vc.parent.isNil { return vc }
        else {return getTopMostLevelParent(for: vc.parent!)}
    }
    /// Returns the highest parent in the viewController heirarchy
    open var topMostLevelParent: UIViewController{
        return getTopMostLevelParent(for: self)
    }
    
    
    
    public func dismissAllPresentedViewControllers(completion: (() -> Void)? = nil){
        if self.presentedViewController.isNil{
            completion?()
            return
        } else if let presented = self.presentedViewController, presented.presentedViewController.isNil{
            presented.dismiss(animated: false, completion: {
                if let presenting = self.presentingViewController{
                    presenting.dismissAllPresentedViewControllers(completion: completion)
                } else {completion?()}
            })
        } else { self.presentedViewController!.dismissAllPresentedViewControllers(completion: completion) }
    }
    
    
}

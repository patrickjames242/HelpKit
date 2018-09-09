//
//  UIView.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension UIView{
    
    open var rightSide: CGFloat {
        get { return frame.rightSide }
        set { frame.rightSide = newValue }
    }
    
    open var leftSide: CGFloat {
        get { return frame.leftSide }
        set { frame.leftSide = newValue }
    }
    
    open var topSide: CGFloat {
        get { return frame.topSide }
        set { frame.topSide = newValue }
    }
    
    open var bottomSide: CGFloat {
        get { return frame.bottomSide }
        set { frame.bottomSide = newValue }
    }
    
    open func stopAnimations(){
        self.subviews.forEach{$0.stopAnimations()}
        self.layer.removeAllAnimations()
        
    }
    
    open func setCornerRadius(to newValue: CGFloat){
        layer.cornerRadius = newValue
        if !layer.masksToBounds{layer.masksToBounds = true}
    }
    
    open func applyShadow(width: CGFloat){
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = width
        self.layer.shadowOffset  = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1
        
    }
    
    /// Positions the view such the specified position in the receiver's bounds is aligned with the provided point in the bounds of its superview.
    open func move(pointInBounds: CGPoint, toPointInSuperViewsBounds newPoint: CGPoint){
        guard let superview = superview else {return}
        let convertedPointInBounds = superview.convert(pointInBounds, from: self)
        let convertedOrigin = superview.convert(bounds.origin, from: self)
        
        let difference = convertedPointInBounds - convertedOrigin
        let newPosition = newPoint - difference
        self.frame.origin = newPosition
        
    }
    
    
    //    private func getViewController(of view: UIView) -> UIViewController?{
    //        if let next = next{
    //            if let next = next as? UIViewController{ return next }
    //            else { return getViewController(of: next as! UIView) }
    //        } else {return nil}
    //    }
    //
    //    /// Returns the view controller whose view the recever either is or is a subview of.
    //    open var viewController: UIViewController?{
    //        return getViewController(of: self)
    //    }
    
    
    open var centerInFrame: CGPoint{
        
        return center
    }
    
    open var centerInBounds: CGPoint{
        return CGPoint(x: bounds.width.half,
                       y: bounds.height.half)
    }
    
    open var halfOfWidth: CGFloat{
        return bounds.width / 2
    }
    
    open var halfOfHeight: CGFloat{
        return bounds.height / 2
    }
    
}

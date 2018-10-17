//
//  PageScrollingInteractor.swift
//  CamChat
//
//  Created by Patrick Hanna on 6/29/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

@objc public protocol PageScrollingInteractorDelegate: class{
    
    @objc optional func gradientDidSnap(fromScreen: PageScrollingInteractor.ScreenType, toScreen: PageScrollingInteractor.ScreenType, direction: ScrollingDirection, interactor: PageScrollingInteractor)
    
    /// Called when the gradient is about to change because of the movement of the user's finger after a period of inactivity.
    @objc optional func gradientWillBeginChanging(interactor: PageScrollingInteractor, direction: ScrollingDirection)
    
    /// gradient is expressed as a percentage from -1 to 0 to +1
    func gradientDidChange(to gradient: CGFloat, direction: ScrollingDirection, interactor: PageScrollingInteractor)

    var view: UIView! { get }
}


open class PageScrollingInteractor: NSObject, UIGestureRecognizerDelegate{
    private weak var view: UIView!

    private weak var pageScrollingDelegate: PageScrollingInteractorDelegate!
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        if otherGestureRecognizer.view is UIScrollView{return false}
        return true
    }
    
    

  
    
    public init(delegate: PageScrollingInteractorDelegate, direction: ScrollingDirection){
        self.scrollingDirection = direction
        self.view = delegate.view
        self.pageScrollingDelegate = delegate
        
        super.init()
        self.gesture = DirectionAwarePanGesture(target: self, action: #selector(respondToGesture(gesture:)))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
    }
    
    public private (set) var gesture: DirectionAwarePanGesture!
    
    
    /// When this is true, gradient changes are only reported when the gesture recognizer detects finger movement in the direction specified when this PageScrollingInteractor was initialized.
    open var onlyAcceptInteractionInSpecifiedDirection = true
    
    
    /// Indicates whether or not the interactor will process events from the gesture recognizer.
    private(set) var isAcceptingTouches = true
    
    
    ///NOTE: Interactor accepts touches by default. It only becomes deactivated if the API user deactivates it.
    
    open func startAcceptingTouches(){
        self.isAcceptingTouches = true
    }
    
    open func stopAcceptingTouches(){
        self.isAcceptingTouches = false
    }
    
    
    
    private let scrollingDirection: ScrollingDirection
    
    
    @objc public enum ScreenType: Int{
        /// For a horizontal interactor, 'first' is the screen on the left. For a vertical interactor, 'first' is the screen on the top.
        case first = -1
        case center = 0
        
        /// For a horizontal interactor, 'last' is the screen on the right. For a vertical interactor, 'last' is the screen on the bottom.
        case last = 1
        
        func rawPointValue(for interactor: PageScrollingInteractor) -> CGFloat {
            return interactor.getRawPointValue(for: self)
        }
    }
    
    private func getRawPointValue(for screenType: ScreenType) -> CGFloat {
        view.layoutIfNeeded()
        let frame = view.frame
        let x: CGFloat
        
        switch self.scrollingDirection{
        case .horizontal: x = frame.width
        case .vertical: x = frame.height
        }
        
    
        switch screenType{
        case .first: return -x
        case .center: return 0
        case .last: return x
        }
    }
    
    
   
    
    
    
    open private (set) var currentGradientPointValue: CGFloat = 0
    
    private func getCurrentGradientPercentage() -> CGFloat{
        view.layoutIfNeeded()
        let dimension: CGFloat
        switch self.scrollingDirection{
        case .horizontal: dimension = view.frame.width
        case .vertical: dimension = view.frame.height
        }
        
        return currentGradientPointValue / dimension
    }
    
    open var currentGradientPercentage: CGFloat{
        return getCurrentGradientPercentage()
    }
    
  
    
    // This function is called by users of the API and NOT BY ANYTHING IN THIS FILE!
    
    open func snapGradientTo(screen: ScreenType, animated: Bool = true){
        pageScrollingDelegate.gradientWillBeginChanging?(interactor: self, direction: scrollingDirection)
        reportGradientSnappedTo(toScreen: screen, animationTime: animated ? 0.2 : nil)
        gesture.setTranslation(CGPoint.zero, in: view)
    }
    
    
    open private(set) var currentlyFullyVisibleScreen = ScreenType.center
    
    ///The translation of the user's finger is multipled by this variable before any delegate methods are sent. This results in the gradient changing at a faster rate than the user's finger (if multiplier is > 1) or at a lower rate than the user's finger (if multiplier < 1).
    open var multiplier: CGFloat = 1.3
    
    @objc private func respondToGesture(gesture: DirectionAwarePanGesture){
        if !self.isAcceptingTouches{return}
        
        if onlyAcceptInteractionInSpecifiedDirection{
            if gesture.scrollingDirection != self.scrollingDirection{return}
        }


        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        let translationToUse: CGFloat
        let velocityToUse: CGFloat
        
        switch self.scrollingDirection{
        case .horizontal:
            translationToUse = translation.x * multiplier
            velocityToUse = abs(velocity.x)
        case .vertical:
            translationToUse = translation.y * multiplier
            velocityToUse = abs(velocity.y)
        }
        
        switch gesture.state{
        case .changed, .began:
            gestureResponse_UserMovedFinger(translationX: translationToUse)
        case .ended, .cancelled:
            gestureResponse_UserLiftedFinger(velocity: velocityToUse)
        default: break
        }
    }
    
    
    
    
    
    private var gradientValues: (center: CGFloat, first: CGFloat, last: CGFloat){
        return (ScreenType.center.rawPointValue(for: self), ScreenType.first.rawPointValue(for: self), ScreenType.last.rawPointValue(for: self))
    }
    
    
    /// Should be true when the user's finger is currently moving on screen or when the ending animation is still occuring.
    private var gradientIsChanging = false
    
    private func gestureResponse_UserMovedFinger(translationX: CGFloat){
        if gradientIsChanging.isFalse{
            gradientIsChanging = true
            pageScrollingDelegate.gradientWillBeginChanging?(interactor: self, direction: scrollingDirection)
        }
        
        let val: CGFloat
        switch currentlyFullyVisibleScreen{
        case .center:
            val = min(max(-translationX, gradientValues.first), gradientValues.last)
            
        case .first:
            if currentGradientPercentage == -1 && translationX >= 0{
                gesture.setTranslation(CGPoint.zero, in: view)
                return
            }
            val = max(gradientValues.first - (translationX), gradientValues.first)
        case .last:
            if currentGradientPercentage == 1 && translationX <= 0{
                gesture.setTranslation(CGPoint.zero, in: view)
                return
            }
            val = min(gradientValues.last - translationX, gradientValues.last)
        }
        reportGradientChangeTo(newGradientPointValue: val)
    }
    
    private func gestureResponse_UserLiftedFinger(velocity: CGFloat){
        
        let threshold = getThresholdFor(velocity: velocity)
        let toScreen: ScreenType
        
        switch currentlyFullyVisibleScreen{
        case .center:
            if currentGradientPointValue < -threshold  {
                toScreen = .first
            } else if currentGradientPointValue > threshold{
                toScreen = .last
            } else { toScreen = .center }
            
        case .first:
            
            if currentGradientPointValue > gradientValues.first + threshold{
                toScreen = .center
            } else { toScreen = .first }
            
        case .last:
            
            if currentGradientPointValue < gradientValues.last - threshold{
                toScreen = .center
            } else { toScreen = .last }
        }
        completeGradientInteractionTo(toScreen: toScreen, velocity: velocity)
    }
    
    
    ///This returns the number of points a view should move in order for it to snap completely on screen or completely off screen.
    private func getThresholdFor(velocity: CGFloat) -> CGFloat{
        if abs(velocity) > 500 { return 10 }
        else {
            let dimension = (self.scrollingDirection == .horizontal) ? view.frame.width : view.frame.height
            return dimension / 2
        }
    }
    
    
    private func reportGradientChangeTo(newGradientPointValue: CGFloat){
        self.currentGradientPointValue = newGradientPointValue
        pageScrollingDelegate.gradientDidChange(to: currentGradientPercentage, direction: scrollingDirection, interactor: self)
        
    }
    
    
    private func completeGradientInteractionTo(toScreen: ScreenType, velocity: CGFloat){
        let remainingDistance = abs(abs(toScreen.rawPointValue(for: self)) - abs(currentGradientPointValue))
        let time = max(min(Double(remainingDistance / velocity), 0.35), 0.15)
        reportGradientSnappedTo(toScreen: toScreen, animationTime: time)
    }
    
    
    
    private func reportGradientSnappedTo(toScreen: ScreenType, animationTime: TimeInterval?) {
        let fromScreen = self.currentlyFullyVisibleScreen
        let action = {
            self.currentlyFullyVisibleScreen = toScreen
            self.reportGradientChangeTo(newGradientPointValue: toScreen.rawPointValue(for: self))
        }
        let completion: (Bool) -> Void = { _ in
            if self.currentGradientPointValue == toScreen.rawPointValue(for: self){
                self.pageScrollingDelegate.gradientDidSnap?(fromScreen: fromScreen, toScreen: toScreen, direction: self.scrollingDirection, interactor: self)
                self.gradientIsChanging = false
            }
        }
        if let time = animationTime{
            UIView.animate(withDuration: time, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: action, completion: completion)
        } else {
            action()
            completion(true)
        }
    }
}

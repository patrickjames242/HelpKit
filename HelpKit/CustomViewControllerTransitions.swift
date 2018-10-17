//
//  Custom ViewController Transitions.swift
//  HelpKit
//
//  Created by Patrick Hanna on 8/6/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit




extension UIViewController: HKVCTransParticipator{
    @objc open var viewControllerForTransition: UIViewController {
        return topMostLevelParent
    }
}




/// There's a problem with this protocol.Usually I mean for these functions to get called on a view controller that is currently being presented or dismissed. However, they will still be called even if the conforming vc is the presenting vc instead of the vc being presented. Sometimes I want this to happen, and other times I don't. In the times that I don't, I don't remember to check whether or not the vc is the one being presented, which results in weird things happening at times. I don't feel like fixing it right now, so this is a reminder.
@objc public protocol HKVCTransEventAwareParticipator: HKVCTransParticipator{
    @objc optional func prepareForPresentation()
    @objc optional func performUnanimatedPresentationAction()
    @objc optional func cleanUpAfterPresentation()
    @objc optional func prepareForDismissal()
    @objc optional func performUnanimatedDismissalAction()
    @objc optional func cleanUpAfterDismissal()
}





@objc public protocol HKVCTransParticipator: class {
    var viewControllerForTransition: UIViewController { get }
}


extension HKVCTransParticipator{
    public var viewController: UIViewController{
        return viewControllerForTransition
    }
    public var view: UIView!{
        return viewController.view
    }
}



open class HKVCTransBrain{
    
    open weak var _presented: HKVCTransParticipator!
    open weak var _presenter: HKVCTransParticipator!
    
    
    open weak var container: UIView!
    
    private func affectEventAwareParticipators(_ action: (HKVCTransEventAwareParticipator) -> Void){
        [_presented as? HKVCTransEventAwareParticipator, _presenter as? HKVCTransEventAwareParticipator].filterOutNils().forEach { action($0) }
    }
    
    public required init(presenter: HKVCTransParticipator, presented: HKVCTransParticipator){
        self._presenter = presenter
        self._presented = presented
    }
    
    open func prepareForPresentation(using context: UIViewControllerContextTransitioning){
        self.container = context.containerView
        affectEventAwareParticipators({$0.prepareForPresentation?()})
        _presenter.view.isUserInteractionEnabled = false
        
    }
    
    open func carryOutUnanimatedPresentationAction() {
        affectEventAwareParticipators({$0.performUnanimatedPresentationAction?()})
    }
    
    open func cleanUpAfterPresentation() {
        affectEventAwareParticipators({$0.cleanUpAfterPresentation?()})
    }
    
    open func prepareForDismissal() {
        affectEventAwareParticipators({$0.prepareForDismissal?()})
    }
    
    open func carryOutUnanimatedDismissalAction() {
        affectEventAwareParticipators({$0.performUnanimatedDismissalAction?()})
    }
    
    /// NOTE: the super implementation MUST be called AFTER the subclass's implementation of this function
    open func cleanUpAfterDismissal() {
        affectEventAwareParticipators({$0.cleanUpAfterDismissal?()})
        _presenter.view.isUserInteractionEnabled = true
        
    }
    
    
}






open class HKVCTransDelegate<BrainType: HKVCTransBrain, AnimationControllerType: HKVCTransAnimationController<BrainType>>: NSObject, UIViewControllerTransitioningDelegate {
    

    public let brain: BrainType
    
    
    public init(presenter: HKVCTransParticipator, presented: HKVCTransParticipator){
        self.brain = BrainType(presenter: presenter, presented: presented)
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationControllerType(brain: brain, config: .presentation)
    }
    
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationControllerType(brain: brain, config: .dismissal)
    }
    
    open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}



open class HKVCTransAnimationController<BrainType: HKVCTransBrain>: NSObject, UIViewControllerAnimatedTransitioning{
    
    
    public enum HKVCTransConfig{ case presentation, dismissal }
    
    public let config: HKVCTransConfig
    
    open var brain: HKVCTransBrain
    
    
    
    
    open var duration: TimeInterval{
        return 0.4
    }
    
    public required init(brain: HKVCTransBrain, config: HKVCTransConfig) {
        self.config = config
        self.brain = brain
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let action: () -> Void
        let completion: () -> Void
        
        switch config{
        case .presentation:
            brain.prepareForPresentation(using: transitionContext)
            action = brain.carryOutUnanimatedPresentationAction
            completion = {
                self.brain.cleanUpAfterPresentation()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        case .dismissal:
            brain.prepareForDismissal()
            action = brain.carryOutUnanimatedDismissalAction
            completion = {
                self.brain.cleanUpAfterDismissal()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        
        if transitionContext.isAnimated{
               getAnimator()(duration, action, {_ in completion()})
        } else {
            action()
            completion()
        }
        
        
    }
    
    open func getAnimator() -> (_ duration: TimeInterval, _ action: @escaping () -> Void, _ completion: @escaping (Bool) -> Void) -> Void{
        return UIView.animate(withDuration:animations:completion:)
    }
}



open class HKVCTransInteractionController<BrainType: HKVCTransBrain>: NSObject, UIViewControllerInteractiveTransitioning {
    
    
    
    public weak var context: UIViewControllerContextTransitioning?
    public let brain: BrainType
    
   
    
    open var interactionInProgress = false
    open var shouldCompleteAnimation = false
    
    public init(brain: BrainType){
        self.brain = brain
    }

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

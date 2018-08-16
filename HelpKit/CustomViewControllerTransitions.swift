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
        return self
    }
}


public protocol HKVCTransParticipator: class {
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
    
    open var _presented: HKVCTransParticipator!
    open var _presenter: HKVCTransParticipator!
    
    open weak var context: UIViewControllerContextTransitioning!
    
    open weak var container: UIView!
    
    public required init(presenter: HKVCTransParticipator, presented: HKVCTransParticipator){
        self._presenter = presenter
        self._presented = presented
    }
    
    open func prepareForPresentation(using context: UIViewControllerContextTransitioning){
        self.context = context
        self.container = context.containerView
    }
    
    open func carryOutUnanimatedPresentationAction() { }
    
    open func cleanUpAfterPresentation() { }
    
    open func prepareForDismissal() { }
    
    open func carryOutUnanimatedDismissalAction() { }
    
    open func cleanUpAfterDismissal() { }
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
    
    
    public enum Config{ case presentation, dismissal }
    
    public let config: Config
    
    open var brain: HKVCTransBrain
    
    
    
    
    open var duration: TimeInterval{
        return 0.4
    }
    
    public required init(brain: HKVCTransBrain, config: Config) {
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
        
        getAnimator()(duration, action, {_ in completion()})
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

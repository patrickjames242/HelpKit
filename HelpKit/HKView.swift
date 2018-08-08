//
//  HKView.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/17/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

open class HKView: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    public init(){
        super.init(frame: CGRect.zero)
        setUpView()
    }
    
    /// This function should NEVER be called directly. It should only be overriden.
    open func setUpView(){
        
        
    }
    
    
    open var layoutSubviewsAction = {}
    open var touchesDidBeginAction = {}
    open var touchesDidEndAction = {}
    open var touchesDidCancelAction = {}
    open var didMoveToWindowAction = {}
    open var didMoveToSuperviewAction = {}
    open var willRemoveFromSuperViewAction = {}
    
    open var pointInsideAction: ((_ point: CGPoint, _ event: UIEvent?) -> Bool)?
    open var hitTestAction: ((_ point: CGPoint, _ event: UIEvent?) -> UIView?)?

    override open func layoutSubviews() {
        super.layoutSubviews()
        layoutSubviewsAction()
    }
    
    open override func removeFromSuperview() {
        willRemoveFromSuperViewAction()
        super.removeFromSuperview()
        
    }
    
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchesDidBeginAction()
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchesDidEndAction()
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchesDidCancelAction()
    }
    
    
    
    open override func didMoveToWindow() {
        super.didMoveToWindow()
        didMoveToWindowAction()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        didMoveToSuperviewAction()
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let action = pointInsideAction{
            return action(point, event)
        }
        return super.point(inside: point, with: event)
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let action = hitTestAction{
            return action(point, event)
        }
        return super.hitTest(point, with: event)
    }
    
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
}

//
//  DirectionAwarePanGesture.swift
//  CamChat
//
//  Created by Patrick Hanna on 7/3/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit


@objc public enum ScrollingDirection: Int { case horizontal = 0, vertical = 1 }


open class DirectionAwarePanGesture: UIPanGestureRecognizer{
    
    
    private(set) var direction: ScrollingDirection?
    
    private var touchesMovedWasAlreadyCalled = false
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        touchesMovedWasAlreadyCalled = false
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        self.direction = nil
        touchesMovedWasAlreadyCalled = false
        super.touchesBegan(touches, with: event)
    }
    
    
    
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {

        if !touchesMovedWasAlreadyCalled{

            touchesMovedWasAlreadyCalled = true
            
            let previousLocation = touches.first!.previousLocation(in: touches.first!.window)
            let currentLocation = touches.first!.location(in: touches.first!.window)
            let translation = currentLocation.getTranslation(from: previousLocation)

            if translation == CGPoint.zero {
                touchesMovedWasAlreadyCalled = false
                return
            }
            if abs(translation.x) > abs(translation.y){
                self.direction = .horizontal
            } else {
                self.direction = .vertical
            }
        }
        super.touchesMoved(touches, with: event)
    }
}

//
//  HKButtonTemplate.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/17/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit


open class HKButtonTemplate: HKView{
    
    
    open var minimumActivationSize = CGSize(width: 60, height: 60)
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        self.layoutIfNeeded()
        
        let height = max(minimumActivationSize.height, bounds.size.height)
        let width = max(minimumActivationSize.width, bounds.size.width)
        
        let newRect = CGRect(center: self.centerInBounds, width: width, height: height)

        return newRect.contains(point)
    }
    
    
    open var isEnabled = true
    
    private var actions = [{}]
    
    public func addAction(_ action: @escaping () -> Void){
        self.actions.append(action)
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !isEnabled { return }
        tapBegan()

    }
    
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if !isEnabled{return}
        tapEnded()
        actions.forEach{$0()}
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if !isEnabled{return}
        tapEnded()
    }
    
    

    
    open func tapBegan(){
        
    }
    
    open func tapEnded(){
        
    }
    
    
    
    
    
    
    
    
}

//
//  HKLayoutGuide.swift
//  HelpKit
//
//  Created by Patrick Hanna on 8/19/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

public class HKLayoutGuide: UILayoutGuide{
    
    public convenience override init(){
        self.init(frame: CGRect.zero)
    }
    
    
    public init(frame: CGRect){
        settableFrame = frame
        super.init()
    }
    
    
    public override var owningView: UIView?{
        didSet{
            if oldValue != nil{
                let constraintArray = [leftConstraint, topConstraint, widthConstraint, heightConstraint].filterOutNils()
                NSLayoutConstraint.deactivate(constraintArray)
            }
            
            if let view = owningView {
                
                let pins = pin(anchors: [.left: view.leftAnchor, .top: view.topAnchor], constants: [.width: settableFrame.width, .height: settableFrame.height, .top: settableFrame.minY, .left: settableFrame.minX])
                topConstraint = pins.top!
                leftConstraint = pins.left!
                widthConstraint = pins.width!
                heightConstraint = pins.height!
                
                
            }
        }
    }
    
    public var settableFrame: CGRect{
        didSet {
           setConstraints(accordingTo: settableFrame)
        }
    }
    
 
    
    private func setConstraints(accordingTo rect: CGRect){
        topConstraint?.constant = rect.minY
        leftConstraint?.constant = rect.minX
        widthConstraint?.constant = rect.width
        heightConstraint?.constant = rect.height
    }
    
    private var topConstraint: NSLayoutConstraint!
    private var leftConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    
    
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not being implemented")
    }
}




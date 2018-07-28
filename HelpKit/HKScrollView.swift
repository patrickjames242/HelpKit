//
//  HKScrollView.swift
//  CamChat
//
//  Created by Patrick Hanna on 7/14/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

public class HKScrollView: UIScrollView{
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
       
    }
    
    public init(){
        super.init(frame: CGRect.zero)
        setUp()
    }
    
    private var contentLayoutGuideHeightAnchor: NSLayoutConstraint!
    private var contentLayoutGuideWidthAnchor: NSLayoutConstraint!
    
    private func setUp(){
        
        let contentLayoutGuidePins = contentLayoutGuide.pin(constants: [.width: contentSize.width, .height: contentSize.height])
        
        contentLayoutGuideWidthAnchor = contentLayoutGuidePins.width!
        contentLayoutGuideHeightAnchor = contentLayoutGuidePins.height!
        
        
        
    }
    
    
    
    
    
    
    override public var contentSize: CGSize{
        get{
            return super.contentSize
        } set {
            super.contentSize = newValue
            contentLayoutGuideHeightAnchor.constant = newValue.height
            contentLayoutGuideWidthAnchor.constant = newValue.width
            layoutIfNeeded()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
}

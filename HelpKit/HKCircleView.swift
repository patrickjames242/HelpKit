//
//  CircleView.swift
//  CamChat
//
//  Created by Patrick Hanna on 7/10/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

open class HKCircleView: HKView {
    
    override open func setUpView() {
        self.backgroundColor = .clear
        layer.addSublayer(circleLayer)
    }
    
   
    
    override open var backgroundColor: UIColor?{
        get{
            if let fillColor = circleLayer.fillColor{
                return UIColor(cgColor: fillColor)
            } else {return nil}
        } set {
           circleLayer.fillColor = newValue?.cgColor
        }
    }
    
    public let circleLayer = CAShapeLayer()
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(arcCenter: centerInBounds, radius: bounds.width / 2, startAngle: 0, endAngle: CGFloat.pi.doubled, clockwise: true)
        circleLayer.path = path.cgPath
    }
    
    
  
}

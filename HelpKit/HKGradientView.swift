//
//  GradientView.swift
//  CamChat
//
//  Created by Patrick Hanna on 7/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//




open class HKGradientView: HKView{
    
    
    public init(colors: [UIColor]){
        super.init(frame: CGRect.zero)
        layer.addSublayer(gradientLayer)
        isUserInteractionEnabled = false
        setGradientColors(colors: colors)
    }
    
    open func setGradientColors(colors: [UIColor]){
        gradientLayer.colors = colors.map{$0.cgColor}
        gradientLayer.locations = colors.indices.map { NSNumber(value: $0 / colors.lastItemIndex!) }
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = self.bounds
        
    }
    
    
    open var gradientLayer = CAGradientLayer()
    
    

    
    
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
}

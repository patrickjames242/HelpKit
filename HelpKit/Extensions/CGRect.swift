//
//  CGRect\.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension CGRect{
    
    
    public init(center: CGPoint, width: CGFloat, height: CGFloat){
        self.init(x: center.x - width.half, y: center.y - height.half, width: width, height: height)
    }
    
    
    public var centerAsFrame: CGPoint{
        return CGPoint(x: minX + (width / 2),
                       y: minY + (height / 2))
    }
    
    public var centerAsBounds: CGPoint{
        return CGPoint(x: width / 2,
                       y: height / 2)
    }
    
    public var rightSide: CGFloat {
        get { return self.maxX }
        set { self.origin.x = newValue - self.width }
    }
    
    public var leftSide: CGFloat {
        get { return self.minX }
        set { self.origin.x = newValue }
    }
    
    public var topSide: CGFloat {
        get { return self.minY }
        set { self.origin.y = newValue }
    }
    
    public var bottomSide: CGFloat {
        get { return self.maxY }
        set { self.origin.y = newValue - self.height }
    }
    
    
    
    
}

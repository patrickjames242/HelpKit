//
//  CGPoint.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit



extension CGPoint{
    static public prefix func -(val: CGPoint) -> CGPoint{
        return CGPoint(x: -val.x, y: -val.y)
    }
    static public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint{
        return lhs.offset(by: rhs)
    }
    static public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint{
        return lhs.offset(by: -rhs)
    }
    
    
    public func getOffset(from point: CGPoint) -> CGPoint{
        return self - point
    }
    
    public func offset(by anotherPoint: CGPoint) -> CGPoint{
        var newPoint = CGPoint.zero
        newPoint.x = x + anotherPoint.x
        newPoint.y = y + anotherPoint.y
        return newPoint
    }
}

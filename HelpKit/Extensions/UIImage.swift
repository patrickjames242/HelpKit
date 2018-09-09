//
//  UIImage.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit


extension UIImage{
    public var templateImage: UIImage{
        return self.withRenderingMode(.alwaysTemplate)
    }
    
    public enum RotationConfig{
        case clockwise90
        case counterClockwise90
        case _180
        
        fileprivate var orientation: UIImage.Orientation{
            switch self{
            case .clockwise90: return .right
            case .counterClockwise90: return .left
            case ._180: return .down
            }
        }
    }
    
    public func rotatedBy(_ rotation: RotationConfig) -> UIImage?{
        if let cgImage = self.cgImage{
            return UIImage(cgImage: cgImage, scale: 1, orientation: rotation.orientation)
        } else {return nil}
        
    }
    
    
    
    
    
}

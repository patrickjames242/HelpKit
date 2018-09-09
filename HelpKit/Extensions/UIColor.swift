//
//  UIColor.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    
    public convenience init(red: CGFloat, green: CGFloat, blue: CGFloat){
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    
    public static var random: UIColor{
        func getRandomNum() -> CGFloat{return CGFloat((0...255).randomElement()!)}
        let random1 = getRandomNum()
        let random2 = getRandomNum()
        let random3 = getRandomNum()
        return UIColor(red: random1, green: random2, blue: random3)
    }
    
    public static func gray(percentage: CGFloat) -> UIColor{
        return UIColor(red: percentage, green: percentage, blue: percentage, alpha: 1)
    }
}

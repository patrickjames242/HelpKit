//
//  String.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension String{
    
    
    public func height(withFixedWidthOf width: CGFloat, font: UIFont) -> CGFloat{
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let boundingRectSize = NSString(string: self).boundingRect(with: size, options: options, attributes: [.font : font], context: nil).size
        return boundingRectSize.height
    }
    
    public var isValidEmail: Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    public func withTrimmedWhiteSpaces() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var asURL: URL?{
        return URL(string: self)
    }
    
    public mutating func capitalizeFirstLetter(){
        self = prefix(1).uppercased() + self.dropFirst()
    }
    
    public func capitalizingFirstLetter() -> String{
        var string = self
        string.capitalizeFirstLetter()
        return string
    }
    
    
    
}

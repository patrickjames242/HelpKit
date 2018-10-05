//
//  UILabel.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension UILabel{
    public convenience init(text: String? = nil, font: UIFont? = nil, textColor: UIColor? = nil){
        self.init()
        self.textColor = textColor ?? .black
        self.text = text
        self.font = font
    }
}

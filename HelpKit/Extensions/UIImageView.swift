//
//  UIImageView.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension UIImageView{
    
    public convenience init(image: UIImage? = nil, contentMode: UIView.ContentMode){
        self.init(image: image)
        self.contentMode = contentMode
    }
    
}

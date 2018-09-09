//
//  UIStackView.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension UIStackView{
    
    open func removeAllArangedSubviews(){
        arrangedSubviews.forEach{self.removeArrangedSubview($0)}
    }
    
}

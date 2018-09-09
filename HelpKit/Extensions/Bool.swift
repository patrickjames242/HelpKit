//
//  Bool.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension Bool{
    /// Changes value of the receiver to the opposite of what it currently is.
    public mutating func toggle(){
        self = !self
    }
    
    public var isFalse: Bool{
        return !self
    }
    
    public var isTrue: Bool{
        return self
    }
    
    
}

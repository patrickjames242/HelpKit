//
//  Sequence.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit


extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    public func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
    
    
}


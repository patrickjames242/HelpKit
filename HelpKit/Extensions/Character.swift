//
//  Character.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension Character{
    public var isNumber: Bool{
        return CharacterSet(charactersIn: String(self)).isSubset(of: CharacterSet.decimalDigits)
    }
    
    public var isLetter: Bool{
        return CharacterSet(charactersIn: String(self)).isSubset(of: CharacterSet.letters)
    }
}

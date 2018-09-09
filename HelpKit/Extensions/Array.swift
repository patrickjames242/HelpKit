//
//  Array.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension Array {
    public var lastItemIndex: Int?{
        if isEmpty{return nil}
        return self.count - 1
    }
}

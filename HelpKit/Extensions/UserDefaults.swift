//
//  UserDefaults.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/16/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

public let UserDefaultsStandard = UserDefaults.standard

extension UserDefaults{
    
    public subscript(_ key: String) -> Any?{
        get { return value(forKey: key) }
        set { setValue(newValue, forKey: key) }
    }
}


//
//  FileManager.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/30/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import Foundation


extension FileManager{
    
    
    public var documentsDirectoryUrl: URL{
        return urls(for: .documentDirectory, in: .userDomainMask).first!
        
    }
    
    
}


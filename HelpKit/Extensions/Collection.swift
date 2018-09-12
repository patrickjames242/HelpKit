//
//  Collection.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/11/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit


extension Collection{
    /// Returns the actual index of the collection you would arrive at if you were to count up to the index provided starting from the opposite end of the collection.
    public func invertedIndexFor(index: Int) -> Int?{
        if index < 0 || index > count - 1 { return nil }
        return count - 1 - index
    }
}


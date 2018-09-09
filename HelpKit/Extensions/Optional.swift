//
//  Optional.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit


public protocol HKOptionalProtocol{
    associatedtype Wrapped
    var unsafelyUnwrapped: Wrapped {get}
    var isNil: Bool{get}
}

extension Optional: HKOptionalProtocol{
    public var isNotNil: Bool{
        return self != nil
    }
    public var isNil: Bool{
        return self == nil
    }
}

extension Sequence where Element: HKOptionalProtocol{
    public func filterOutNils() -> [Element.Wrapped]{
        return self.filter({$0.isNil.isFalse}).map{$0.unsafelyUnwrapped}
    }
}


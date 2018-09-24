//
//  WeakWrapper.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/21/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//




public protocol WeakWrapperDelegate: class {
    func wrapperValueWasSetToNil(wrapper: WeakWrapperProtocol)
}



public protocol WeakWrapperProtocol: class {
    var delegate: WeakWrapperDelegate? {get set}
    var unTypedValue: AnyObject? {get}
    var unTypedSelf: NSObject {get}
}



/// This class allows you to place class instances in arrays without worry that the array will prevent the instances from being deallocated.
open class WeakWrapper<Value: AnyObject>: NSObject, WeakWrapperProtocol{
    
    public var unTypedSelf: NSObject{
        return self
    }
    
    public var unTypedValue: AnyObject?{
        return self.value as AnyObject
    }

    weak open var delegate: WeakWrapperDelegate?
    weak open var value: Value?{
        didSet{
            if value == nil{
                delegate?.wrapperValueWasSetToNil(wrapper: self)
            }
        }
    }
    
    public init(_ value: Value){
        self.value = value
    }
}

extension Array where Element: WeakWrapper<AnyObject>{
    
    public mutating func purgeNils(){
        self = filter {$0.value != nil}
    }
    
}

//
//  HKBox.swift
//  HelpKit
//
//  Created by Patrick Hanna on 10/6/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//


//WRITE SOME TESTS FOR THIS!!!!!
public class HKBox<Value>{
    
    
    
    public var value: Value{
        didSet{ observers.values.forEach{$0.forEach{$0(value)}} }
    }
    
    public init(_ value: Value){
        self.value = value
    }
    
    
    private var observers = [WeakWrapper<AnyObject>: [(Value) -> Void]]()
    
    public func addChangeObserver(_ sender: AnyObject, action: @escaping (Value) -> Void){
        
        for observer in observers.keys where observer.value === sender{
            observers[observer]!.append(action)
            return
        }
        observers[WeakWrapper(sender)] = [action]
    }
    
    public func removeObserver(_ sender: AnyObject){
        for observer in observers.keys where observer.value === sender{
            observers[observer] = nil
        }
    }
    
    
}

extension HKBox: WeakWrapperDelegate{
    public func wrapperValueWasSetToNil(wrapper: WeakWrapperProtocol) {
        for key in observers.keys where key === wrapper.unTypedSelf{
            observers[key] = nil
        }
    }
}





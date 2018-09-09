//
//  HKCache.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/4/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//



public class HKCache<KeyType: Hashable, ValueType>{
    
    private let objectLimit: Int
    
    public init(objectLimit: Int){
        self.objectLimit = objectLimit
    }
    
    
    private var objectDict = [KeyType: ValueType]()
    
    private var keyArray = [KeyType](){
        didSet {
            if keyArray.count > objectLimit {
                for _ in 1...(keyArray.count - objectLimit){
                    objectDict[keyArray.first!] = nil
                    keyArray.removeFirst()
                }
            }
        }
    }
    
    
    public func set(value: ValueType, forKey key: KeyType){
        objectDict[key] = value
        if keyArray.contains(key).isFalse { keyArray.append(key) }
    }
    
    public func valueFor(key: KeyType) -> ValueType?{
        return objectDict[key]
    }
}

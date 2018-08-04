//
//  EArray.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/21/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit


/// This struct allows the efficiency of Dictionaries and Sets while still providing the convenience of ordered items like arrays. Through the irateThrough and addBatch functions you can add thousands of items at the same speed you would in a Dictionary or Set while still preserving their order.

public struct EArray<Element>{
    
    
    
    private var storage = [Int: Element]()
    
    public init(array: Array<Element>) {
        self.add(contentsOf: array)
    }
    
    public init() { }
    
    
    
    public var elements: [Element]{
        if storage.isEmpty { return [] }
        var arrayToReturn: [Any] = Array(repeating: "x", count: storage.count)
        for i in 0...(storage.count - 1){
            arrayToReturn[i] = storage[i]!
        }
        return arrayToReturn as! [Element]
    }
    
    
    public mutating func removeAll(){
        storage.removeAll()
    }
    
    public mutating func add(_ element: Element){
        storage[storage.count] = element
    }
    
    public mutating func add(contentsOf array: [Element]){
        
        for element in array{
            add(element)
        }
        
    }
    
    public mutating func irateThrough<x>(array: [x], extractValue: (x) -> Element?){
        var z = storage.count
        for y in array{
            
            if let result = extractValue(y){
                self.storage[z] = result
                z += 1
            } else {continue}
        }
    }
    
    public mutating func addBatch (numberOfTimes: Int, extractValue: () -> Element){
        var z = storage.count
        let count = storage.count
        
        repeat{
            self.storage[z] = extractValue()
            z += 1
        } while  z < count + numberOfTimes
        
    }
    
    public mutating func addBatch(numberOfTimes: Int, extractValue: (_ currentIndex: Int) -> Element){
        
        var z = storage.count
        let count = storage.count
        
        repeat{
            self.storage[z] = extractValue(z - count)
            z += 1
        } while  z < count + numberOfTimes
    }
}


//CONVENIENT CONFORMANCES

extension EArray: ExpressibleByArrayLiteral, CustomStringConvertible {
    
    public var description: String{
        return storage.values.description
    }
    
    
    public init(arrayLiteral elements: Element...) {
        self.init(array: elements)
    }
    
    public typealias ArrayLiteralElement = Element
    
    public subscript(index: Int) -> Element?{
        return storage[index]
    }
    
    
}

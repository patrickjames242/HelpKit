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
    

    fileprivate var storage = [Int: Element]()
    
    public init(array: Array<Element>) {
        self.append(contentsOf: array)
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
    

    
    public mutating func iterateThrough<X, Y: Sequence>(_ sequence: Y, extractValue: (X) -> Element?) where Y.Element == X{
        var z = storage.count
        
        for y in sequence{
            
            if let result = extractValue(y){
                self.storage[z] = result
                z += 1
            } else {continue}
        }
    }
    
    public mutating func addBatch (numberOfTimes: Int, extractValue: @autoclosure () -> Element){
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

extension EArray: Equatable where Element: Equatable { }
extension EArray: Hashable where Element: Hashable { }
extension EArray: Codable where Element: Codable { }
extension EArray: BidirectionalCollection { }
extension EArray: RandomAccessCollection { }
extension EArray: RangeReplaceableCollection { }



extension EArray: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.init(array: elements)
    }
}

extension EArray: CustomStringConvertible{
    public var description: String{
        return storage.values.description
    }
}

public struct EArrayIterator<Element>: IteratorProtocol{
    fileprivate init(earray: EArray<Element>){
        self.earray = earray
    }
    
    private var currentIndex = 0
    
    private let earray: EArray<Element>
    
    mutating public func next() -> Element? {
        if currentIndex == earray.storage.count {return nil}
        let elementToReturn = earray.storage[currentIndex]
        currentIndex += 1
        return elementToReturn
    }
}


extension EArray: Sequence{
    
    public typealias Iterator = EArrayIterator<Element>
    public func makeIterator() -> EArray<Element>.Iterator {
        return EArrayIterator(earray: self)
    }
}




extension EArray: MutableCollection{
    public var startIndex: Int{
        return 0
    }
    
    public var endIndex: Int{
        return storage.count
    }
    public func index(after i: Int) -> Int {
        if !(i < endIndex) { fatalError("index out of bounds") }
        return i + 1
    }
    public subscript(position: Int) -> Element{
        get{
            if !(startIndex..<endIndex).contains(position){fatalError( "index \(position) out of bounds")}
            return storage[position]!
        }
        set{
            if position < startIndex || position > endIndex - 1{fatalError("index \(position) out of bounds")}
            storage[position] = newValue
        }
    }
}














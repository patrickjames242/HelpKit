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
    
    /// Breaks the receiver up into a twoDimentional array according to the result of the closure on each element
    public func splitUp(isIncludedInCurrentSubArray: (_ previousElementInSubArray: Element, _ currentElement: Element) -> Bool) -> [[Element]]{
        
        var elementsToReturn = [[Element]]()
        var currentChunk = [Element]()
        if let first = first {currentChunk = [first]} else {return []}
        
        for element in self.dropFirst() {
            
            if isIncludedInCurrentSubArray(currentChunk.last!, element){
                currentChunk.append(element)
            } else {
                elementsToReturn.append(currentChunk)
                currentChunk = [element]
            }
        }
        elementsToReturn.append(currentChunk)
        
        return elementsToReturn
    }
    
    /// Returns the first items in the array in the amount specified.
    public func firstItems(_ numberOfItems: Int) -> [Element]{
        if numberOfItems <= 0{return []}
        return (0...(numberOfItems - 1)).map{item(at: $0)}.filterOutNils()
    }
    
    /// Returns the last items in the array in the amount specified.
    public func lastItems(_ numberOfItems: Int) -> [Element]{
        if numberOfItems <= 0 || isEmpty {return []}
        let invertedRangeEndIndex = self.invertedIndexFor(index: numberOfItems - 1) ?? 0
        
        return (invertedRangeEndIndex...lastItemIndex!).map{item(at: $0)}.filterOutNils()
    }
    
    
    
}



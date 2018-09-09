//
//  HKCacheTests.swift
//  HelpKitTests
//
//  Created by Patrick Hanna on 9/4/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import XCTest
@testable import HelpKit


class HKCacheTests: XCTestCase{
    
    
    
    
    func testStoresValuesGiven(){
        let pair1 = (key: 1, value: "test test test")
        let pair2 = (key: 2, value: "test123455")
        
        let cache = HKCache<Int, String>(objectLimit: 40)
        
        cache.set(value: pair1.value, forKey: pair1.key)
        cache.set(value: pair2.value, forKey: pair2.key)
        
        XCTAssertEqual(cache.valueFor(key: pair1.key), pair1.value)
        XCTAssertEqual(cache.valueFor(key: pair2.key), pair2.value)
    }
    
    
    func testRemovesFirstValuesWhenOverObjectLimit(){
        let cache = HKCache<Int, String>(objectLimit: 10)
        let pair1 = (key: 0, value: "test test test")
        let pair2 = (key: 1, value: "fkjalsdkfjal;skdjf")
        
        cache.set(value: pair1.value, forKey: pair1.key)
        cache.set(value: pair2.value, forKey: pair2.key)
        
        for i in 2...9{
            cache.set(value: "test test test \(i)", forKey: i)
            XCTAssertNotNil(cache.valueFor(key: pair1.key))
            XCTAssertNotNil(cache.valueFor(key: pair2.key))
        }
        
        cache.set(value: "test234921", forKey: 50)
        cache.set(value: "lskdfjlaksd", forKey: 51)
        
        XCTAssertNil(cache.valueFor(key: pair1.key))
        XCTAssertNil(cache.valueFor(key: pair2.key))
    }
    

    func testValueOverwriteDoesNotIncreaseObjectCount(){
        let cache = HKCache<Int, String>(objectLimit: 5)
        
        for i in 1...5{
            cache.set(value: "testing\(i)", forKey: i)
        }
        cache.set(value: "testing testing testing", forKey: 1)
        XCTAssertNotNil(cache.valueFor(key: 1))
    }
    
    
}




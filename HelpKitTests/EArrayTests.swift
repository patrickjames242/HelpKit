//
//  EArray.swift
//  HelpKitTests
//
//  Created by Patrick Hanna on 8/27/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//
import XCTest
@testable import HelpKit

class EArrayTests: XCTestCase{
    
    func testsOuputsCorrectArray(){
        let array = ["Patrick", "Pharez", "John", "Jayde"]
        let eArray: EArray<String> = ["Patrick", "Pharez", "John", "Jayde"]
        XCTAssertEqual(array, eArray.elements)
    }
}

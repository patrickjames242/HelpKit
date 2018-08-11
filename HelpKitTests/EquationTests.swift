//
//  EquationTests.swift
//  HelpKitTests
//
//  Created by Patrick Hanna on 8/11/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import XCTest
@testable import HelpKit



class LinearEquationTests: XCTestCase{
    
    func testEquationInitsFailWhenInvalid(){
        let equation1 = LinearEquation(xy(1, 1), xy(1, 1))
        let equation2 = LinearEquation(xy(1, 4), xy(1, 7))
        
        XCTAssertNil(equation1)
        XCTAssertNil(equation2)
    }
    
    
    func testSpecifiedPointsAreIncludedInEquation(){
        
        let equation1 = LinearEquation(xy(1, 1), xy(2, 5))!
        
        XCTAssertEqual(equation1.solve(for: 1), 1)
        XCTAssertEqual(equation1.solve(for: 2), 5)
        
        let equation2 = LinearEquation(xy(8, 10), xy(9, 34))!
        
        XCTAssertEqual(equation2.solve(for: 8), 10)
        XCTAssertEqual(equation2.solve(for: 9), 34)
    }
    
    func testRespectsMinAndMaxValues(){
        let equation1 = LinearEquation(xy(1, -500), xy(2, 1000), min: 1, max: 500)!
        
        XCTAssertEqual(equation1.solve(for: 1), 1)
        XCTAssertEqual(equation1.solve(for: 2), 500)
        
        let equation2 = LinearEquation(xy(10, 1000), xy(1, -1000), min: 1, max: 2)!
        XCTAssertEqual(equation2.solve(for: 10), 2)
        XCTAssertEqual(equation2.solve(for: 1), 1)
        
    }
}

class AbsoluteValueEquationTests: XCTestCase{
    
    
    func testEquationInitsFailWhenInvalid(){
        let equation1 = AbsoluteValueEquation(xy(1, 23), xy(3, 201), xy(5, 501))
        let equation2 = AbsoluteValueEquation(xy(1, 1), xy(1,7), xy(4, 7))
        
        XCTAssertNil(equation1)
        XCTAssertNil(equation2)
    }
    
    func testSpecifiedPointsAreIncludedInEquation(){
        let equation1 = AbsoluteValueEquation(xy(1, 23), xy(3, 201), xy(5, 23))!
        
        XCTAssertEqual(equation1.solve(for: 1), 23)
        XCTAssertEqual(equation1.solve(for: 3), 201)
        XCTAssertEqual(equation1.solve(for: 5), 23)
        
        let equation2 = AbsoluteValueEquation(xy(-1, 10), xy(0, 4), xy(1, 9))!
        
        XCTAssertEqual(equation2.solve(for: -1), 10)
        XCTAssertEqual(equation2.solve(for: 0), 4)
        XCTAssertEqual(equation2.solve(for: 1), 9)
    }
    
    func testRespectsMinAndMaxValues(){
        let equation = AbsoluteValueEquation(xy(-1, 100), xy(0, -100), xy(1, 100), min: 0, max: 0.5)!
        XCTAssertEqual(equation.solve(for: -1), 0.5)
        XCTAssertEqual(equation.solve(for: 0), 0)
    }
}


class QuadradicEquationTests: XCTestCase{
    
    func testEquationInitsFailWhenInvalid(){
        let equation1 = QuadraticEquation(xy(2, 3), xy(4, 10), xy(4, 100))
        let equation2 = QuadraticEquation(xy(2,2), xy(2,2), xy(2, 3))
        
        XCTAssertNil(equation1)
        XCTAssertNil(equation2)
    }
    
    func testSpecifiedPointsAreIncludedInEquation(){
        let equation1 = QuadraticEquation(xy(2, 3), xy(4, 10), xy(100, 100))!
        
        XCTAssertEqual(equation1.solve(for: 2).rounded(), 3)
        XCTAssertEqual(equation1.solve(for: 4).rounded(), 10)
        XCTAssertEqual(equation1.solve(for: 100).rounded(), 100)
        
        let equation2 = QuadraticEquation(xy(1,2), xy(2,2), xy(3, 2))!
        
        XCTAssertEqual(equation2.solve(for: 1).rounded(), 2)
        XCTAssertEqual(equation2.solve(for: 2).rounded(), 2)
        XCTAssertEqual(equation2.solve(for: 3).rounded(), 2)
    }
    
    func testRespectsMinAndMaxValues(){
    let equation = QuadraticEquation(xy(-1, 100), xy(0, -100), xy(1, 100), min: 0, max: 0.5)!
        
        XCTAssertEqual(equation.solve(for: -1), 0.5)
        XCTAssertEqual(equation.solve(for: 0), 0)
    }
}

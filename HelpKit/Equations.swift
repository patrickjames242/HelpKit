//
//  Equations.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/24/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit
import simd

public func solveQuadratically(x: CGFloat = 0, a: CGFloat = 0, b: CGFloat = 0, c: CGFloat = 0, min: CGFloat? = nil, max: CGFloat? = nil) -> CGFloat{
    
    var val = (a * pow(x, 2)) + (b * x) + c
    if let min = min{
        val = Swift.max(val, min)
    }
    if let max = max{
        val = Swift.min(val, max)
    }
    return val
}

public func solveLinearly(x: CGFloat = 0, a: CGFloat = 0, b: CGFloat = 0, min: CGFloat? = nil, max: CGFloat? = nil) -> CGFloat {
    
    var val = ((a * x) + b)
    if let min = min{
        val = Swift.max(val, min)
    }
    if let max = max{
        val = Swift.min(val, max)
    }
    return val
}













public struct xy<Number: BinaryFloatingPoint>{
    public let x: Number
    public let y: Number
   
    public init(_ x: Number, _ y: Number){
        self.x = x
        self.y = y
    }
}



public class Equation<Number: BinaryFloatingPoint>{
    
    
    public init(min: Number?, max: Number?){
        self.min = min
        self.max = max
    }
    
    private let min: Number?
    private let max: Number?
    
    fileprivate func performCalculation(for x: Number) -> Number{
        return 1
    }
    
    public func solve(for x: Number) -> Number{
        
        var val = performCalculation(for: x)
        if let min = min{
            val = Swift.max(val, min)
        }
        if let max = max{
            val = Swift.min(val, max)
        }
        return Number(val)
    }
    
    
}


public typealias CGLinearEquation = LinearEquation<CGFloat>

public class LinearEquation<Number: BinaryFloatingPoint>: Equation<Number>{
    
    public init(_ c1: xy<Number>, _ c2: xy<Number>, min: Number? = nil, max: Number? = nil){
        let slope = (c2.y - c1.y) / (c2.x - c1.x)
        let yIntercept = c1.y - (c1.x * slope)
        
        self.slope = slope
        self.yIntercept = yIntercept
        super.init(min: min, max: max)
    }
    
    private let slope: Number
    private let yIntercept: Number

    override func performCalculation(for x: Number) -> Number {
        return ((slope * x) + yIntercept)
    }
    
    
}


public typealias CGQuadEquation = QuadraticEquation<CGFloat>

public class QuadraticEquation<Number: BinaryFloatingPoint>: Equation<Number>{
    
    public init(_ c1: xy<Number>, _ c2: xy<Number>, c3: xy<Number>, min: Number? = nil, max: Number? = nil){
        let coefficientMatrix = simd_double3x3([
            simd_double3([pow(Double(c1.x), 2.0), Double(c1.x), 1.0]),
            simd_double3([pow(Double(c2.x), 2.0), Double(c2.x), 1.0]),
            simd_double3([pow(Double(c3.x), 2.0), Double(c3.x), 1.0])
            ])
        let yMatrix = simd_double3([Double(c1.y), Double(c2.y), Double(c3.y)])
        let answer = simd_mul(yMatrix, coefficientMatrix.inverse)
        
        self.a = Number(answer.x)
        self.b = Number(answer.y)
        self.c = Number(answer.z)
        
        super.init(min: min, max: max)
        
    }
    
    private let a: Number
    private let b: Number
    private let c: Number
    
    override func performCalculation(for x: Number) -> Number {
        
        return (a * Number(pow(Double(x), 2))) + (b * x) + c
    }

    
    
    
    
}

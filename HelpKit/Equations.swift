//
//  Equations.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/24/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit
import simd


public struct xy<Number: BinaryFloatingPoint>: Equatable{
    
    /// Returns true if the array of points are valid to be used in an equation, and false if they are not valid.
 
    static func checkValidity(of points: [xy<Number>]) -> Bool{
        for (x, point) in points.enumerated(){
            
            var newArray = points
            newArray.remove(at: x)
            
            if !newArray.filter({$0.x == point.x}).isEmpty{return false}
        }
        return true
    }
    
    public let x: Number
    public let y: Number
   
    
    
    public init(_ x: Number, _ y: Number){
        self.x = x
        self.y = y
    }
}

public typealias CGEquation = Equation<CGFloat>


/// This is just the abstract superclass of all Equation classes.
public class Equation<Number: BinaryFloatingPoint>{
    
    
    
    fileprivate init(min: Number?, max: Number?){
        self.min = min
        self.max = max
    }
    
    fileprivate let min: Number?
    fileprivate let max: Number?
    
    fileprivate func performCalculation(for x: Number) -> Number{
        return 1
    }
    
    public func uniting(_ equation: Equation<Number>, after xVal: Number) -> EquationUnion<Number>{
        return EquationUnion(join: equation, to: self, after: xVal)
    }
    
    public subscript (x: Number) -> Number{
        return solve(for: x)
    }
    
    final public func solve(for x: Number) -> Number{
        
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
    
    public convenience init?(_ c1: xy<Number>, _ c2: xy<Number>, min: Number? = nil, max: Number? = nil) {
        if !xy.checkValidity(of: [c1, c2]){return nil}
        let slope = (c2.y - c1.y) / (c2.x - c1.x)
        self.init(slope: slope, point: c2, min: min, max: max)
    }
   
    fileprivate init(slope: Number, point: xy<Number>, min: Number? = nil, max: Number? = nil){
        self.slope = slope
        let yIntercept = point.y - (point.x * slope)
        self.yIntercept = yIntercept
        super.init(min: min, max: max)
    }
    
    
    fileprivate let slope: Number
    fileprivate let yIntercept: Number

    override func performCalculation(for x: Number) -> Number {
        return ((slope * x) + yIntercept)
    }
    
    open func intersect(_ otherLine: LinearEquation<Number>) -> xy<Number>{
        let x = (otherLine.yIntercept - yIntercept) / (slope - otherLine.slope)
        let y = solve(for: x)
        return xy(x, y)
    }
    
}











public typealias CGQuadEquation = QuadraticEquation<CGFloat>

public class QuadraticEquation<Number: BinaryFloatingPoint>: Equation<Number>{
    
    public init?(_ c1: xy<Number>, _ c2: xy<Number>, _ c3: xy<Number>, min: Number? = nil, max: Number? = nil){
        if !xy.checkValidity(of: [c1, c2, c3]){return nil}
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

















public typealias CGAbsEquation = AbsoluteValueEquation<CGFloat>

public class AbsoluteValueEquation<Number: BinaryFloatingPoint>: Equation<Number>{
    
    public init?(_ c1: xy<Number>, _ c2: xy<Number>, _ c3: xy<Number>, min: Number? = nil, max: Number? = nil){
        if !xy.checkValidity(of: [c1, c2, c3]){return nil}
        let points = [c1, c2, c3].sorted{$0.x < $1.x}
        
        let line1 = LinearEquation<Number>(points[0], points[1])!
        let line2 = LinearEquation<Number>(points[1], points[2])!
        
        let testLine1 = LinearEquation<Number>(slope: -line1.slope, point: c3)
        let testLine2 = LinearEquation<Number>(slope: -line2.slope, point: c1)
        
        let testIntersect1 = line1.intersect(testLine1)
        let testIntersect2 = line2.intersect(testLine2)
        
        if testIntersect1.x >= points[1].x && testIntersect1.x <= points[2].x{
            self.vertex = line1.intersect(testLine1)
            self.slope = testLine1.slope
        } else if testIntersect2.x <= points[1].x && testIntersect2.x <= points[0].x {
            self.vertex = line2.intersect(testLine2)
            self.slope = testLine2.slope
        } else { return nil }
        
        super.init(min: min, max: max)
    }
    
    private let vertex: xy<Number>
    private let slope: Number
    
    
    override func performCalculation(for x: Number) -> Number {
        return (slope * abs(x - vertex.x)) + vertex.y
    }
}









/// Joins two equations, such that at some specified point, EquationUnion stop evaluating the first equation to produce the y value and instead uses the second equation.

public class EquationUnion<Number: BinaryFloatingPoint>: Equation<Number>{
    
    fileprivate init(join e2: Equation<Number>, to e1: Equation<Number>, after joinXVal: Number){
        self.e1 = e1; self.joinXVal = joinXVal; self.e2 = e2
        super.init(min: nil, max: nil)
    }
    
    private init(oldEquation: EquationUnion<Number>, min: Number?, max: Number?){
        self.e1 = oldEquation.e1
        self.e2 = oldEquation.e2
        self.joinXVal = oldEquation.joinXVal
        super.init(min: min, max: max)
    }
    
    private let e1: Equation<Number>
    private let joinXVal: Number
    private let e2: Equation<Number>
    
    override func performCalculation(for x: Number) -> Number {
        if x <= joinXVal { return e1.solve(for: x) }
        else { return e2.solve(for: x) }
    }
    
    
    public func withMinAndMax(of min: Number?, _ max: Number?) -> EquationUnion<Number>{
        return EquationUnion<Number>(oldEquation: self, min: min, max: max)
    }
}

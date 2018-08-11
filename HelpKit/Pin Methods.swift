//
//  Pin Methods.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/14/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit










public enum ConstraintDimension{
    case left
    case right
    case centerX
    case centerY
    case top
    case bottom
    case height
    case width
    
}

public enum MultipliableConstraintDimension{
    case height
    case width
}




public protocol Pinnable {
    
    var bottomAnchor: NSLayoutYAxisAnchor {get}
    var topAnchor: NSLayoutYAxisAnchor {get}
    var leftAnchor: NSLayoutXAxisAnchor {get}
    var rightAnchor: NSLayoutXAxisAnchor {get}
    var widthAnchor: NSLayoutDimension {get}
    var heightAnchor: NSLayoutDimension {get}
    var centerXAnchor: NSLayoutXAxisAnchor {get}
    var centerYAnchor: NSLayoutYAxisAnchor {get}
    
}

extension UIView: Pinnable {}
extension UILayoutGuide: Pinnable {}

public protocol PinnableLayoutAnchor{}

extension NSLayoutAnchor: PinnableLayoutAnchor {}

public extension Pinnable{
    
    
    
    
    
    
    @discardableResult public func pinAllSides(addTo view: UIView? = nil, pinTo object: Pinnable, insets: UIEdgeInsets = UIEdgeInsets.zero) -> Pins{
        let pins = pin(addTo: view,
                   anchors: [.left: object.leftAnchor, .right: object.rightAnchor, .top: object.topAnchor, .bottom: object.bottomAnchor],
                   constants: [.left: insets.left, .right: insets.right, .top: insets.top, .bottom: insets.bottom])
        return pins
    }
    
    
    
    private func addMyselfTo(view: UIView?){
        guard let view = view else {return}
        
        if self is UIView{
            view.addSubview(self as! UIView)
        }
        if self is UILayoutGuide{
            view.addLayoutGuide(self as! UILayoutGuide)
        }
    }
    
    
    /**
     Call this function as a substitute for UIKit's individual constraint functions.
     
     Note that for the constants parameter, the values given for .left, .right, .top, and .bottom keys are treated as INSETS. This means that if the rightAnchor of view1 is pinned to the leftAnchor of view2 with a constant of 10, view1's right edge will be 10 points to the left of view2's left edge.
     **/
    
    
    @discardableResult public func pin(addTo view: UIView? = nil, anchors: [ConstraintDimension: PinnableLayoutAnchor] = [:], constants: [ConstraintDimension: CGFloat] = [:], multipliers: [MultipliableConstraintDimension: CGFloat] = [:]) -> Pins {
        
        let pins = Pins()

        if let view = self as? UIView{
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addMyselfTo(view: view)
        
        func sendError(_ problemDimension: ConstraintDimension){
            print("Something went wrong when trying to set a \(problemDimension) dimension constraint.")
            fatalError()
        }
        
        
        
        if let left = anchors[.left] {
            if let left = left as? NSLayoutXAxisAnchor{
                let leftInset = constants[.left] ?? 0
                pins.left = leftAnchor.constraint(equalTo: left, constant: leftInset)
                
            } else { sendError(.left) }
        }
        
        if let right = anchors[.right] {
            if let right = right as? NSLayoutXAxisAnchor{
                let rightInset = constants[.right] ?? 0
                pins.right = rightAnchor.constraint(equalTo: right, constant: -rightInset)
            } else { sendError(.right) }
        }
        
        if let top = anchors[.top] {
            if let top = top as? NSLayoutYAxisAnchor {
                let topInset = constants[.top] ?? 0
                
                pins.top = topAnchor.constraint(equalTo: top, constant: topInset)
            } else { sendError(.top) }
        }
        
        if let bottom = anchors[.bottom] {
            if let bottom = bottom as? NSLayoutYAxisAnchor {
                let bottomInset = constants[.bottom] ?? 0
                pins.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -bottomInset)
            } else { sendError(.bottom) }
        }
        
        if let centerX = anchors[.centerX] {
            if let centerX = centerX as? NSLayoutXAxisAnchor {
                let centerXConst = constants[.centerX] ?? 0
                pins.centerX = centerXAnchor.constraint(equalTo: centerX, constant: centerXConst)
            } else { sendError(.centerX) }
        }
        
        if let centerY = anchors[.centerY] {
            if let centerY = centerY as? NSLayoutYAxisAnchor {
                let centerYConst = constants[.centerY] ?? 0
                pins.centerY = centerYAnchor.constraint(equalTo: centerY, constant: centerYConst)
            } else { sendError(.centerY) }
        }
        
        
        if let height = anchors[.height] {
            if let height = height as? NSLayoutDimension {
                let heightConst: CGFloat = constants[.height] ?? 0
                let heightMul: CGFloat = multipliers[.height] ?? 1
                pins.height = heightAnchor.constraint(equalTo: height, multiplier: heightMul, constant: heightConst)
            } else { sendError(.height) }
        } else {
            if let heightConst = constants[.height]{
                pins.height = heightAnchor.constraint(equalToConstant: heightConst)
            }
        }
        
        if let width = anchors[.width]{
            if let width = width as? NSLayoutDimension {
                let widthConst: CGFloat = constants[.width] ?? 0
                let widthMul: CGFloat = multipliers[.width] ?? 1
                pins.width = widthAnchor.constraint(equalTo: width, multiplier: widthMul, constant: widthConst)
            } else { sendError(.width) }
        } else {
            if let widthConst = constants[.width]{
                pins.width = widthAnchor.constraint(equalToConstant: widthConst)
            }
        }
        pins.activateAll()
        
        return pins
    }
    
    @discardableResult public func pin(addTo view: UIView? = nil, anchors: [ConstraintDimension: PinnableLayoutAnchor] = [:], constants: [ConstraintDimension: CGFloat] = [:]) -> Pins {
        return self.pin(addTo: view, anchors: anchors, constants: constants, multipliers: [:])
    }
    
    @discardableResult public func pin(addTo view: UIView? = nil, anchors: [ConstraintDimension: PinnableLayoutAnchor] = [:]) -> Pins {
        return self.pin(addTo: view, anchors: anchors, constants: [:], multipliers: [:])
    }
}





public class Pins{
    
    fileprivate init(){ }
    
    
    public var left: NSLayoutConstraint?
    public var right: NSLayoutConstraint?
    
    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?
    
    public var height: NSLayoutConstraint?
    public var width: NSLayoutConstraint?
    
    public var centerX: NSLayoutConstraint?
    public var centerY: NSLayoutConstraint?
    
    
    public var all: [NSLayoutConstraint]{
        
        var values = [NSLayoutConstraint]()
        
        if let left = left { values.append(left) }
        if let right = right { values.append(right) }
        if let top = top { values.append(top) }
        if let bottom = bottom { values.append(bottom) }
        if let height = height { values.append(height) }
        if let width = width { values.append(width) }
        if let centerX = centerX { values.append(centerX) }
        if let centerY = centerY { values.append(centerY) }
        
        return values
    }
    
    public var allActive: [NSLayoutConstraint]{
        return all.filter {$0.isActive}
    }
    
    
    public func activateAll(){
        NSLayoutConstraint.activate(all)
    }
    public func deactivateAll(){
        NSLayoutConstraint.deactivate(all)
    }
    
}















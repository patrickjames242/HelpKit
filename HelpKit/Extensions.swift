//
//  Extensions.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/17/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit





extension UIGestureRecognizer{
    
    open func stopInterferingWithTouchesInView(){
        cancelsTouchesInView = false
        delaysTouchesBegan = false
        delaysTouchesEnded = false
    }
    
    open func beginInterferingWithTouchesInView(){
        cancelsTouchesInView = true
        delaysTouchesBegan = true
        delaysTouchesEnded = true
    }
}






extension CGPoint{
    
    public func offset(by x: CGFloat, y: CGFloat) -> CGPoint{
        var newPoint = self
        newPoint.x += x
        newPoint.y += y
        return newPoint
    }
    
    public func getTranslation(from previousPoint: CGPoint) -> CGPoint{
        var newPoint = CGPoint.zero
        newPoint.x = self.x - previousPoint.x
        newPoint.y = self.y - previousPoint.y
        return newPoint
    }
    
    public func translated(by anotherPoint: CGPoint) -> CGPoint{
        var newPoint = CGPoint.zero
        newPoint.x = self.x + anotherPoint.x
        newPoint.y = self.y + anotherPoint.y
        return newPoint
    }
}






extension UIViewController{
    
    open var statusBar: UIWindow{
        return UIApplication.shared.value(forKey: "statusBarWindow") as! UIWindow
    }
    
    
    
}

public func editKeyboardWindows(action: (UIWindow) -> Void){
    for window in UIApplication.shared.windows where window !== UIApplication.shared.keyWindow{
        action(window)
    }
}






extension CGFloat{
    public var half: CGFloat{
        return self / 2
    }
}

extension UIStackView{
    
    open func removeAllArangedSubviews(){
        arrangedSubviews.forEach{self.removeArrangedSubview($0)}
    }
    
}







extension NSLayoutConstraint{
    func activate(){
        isActive = true
    }
    func deactivate(){
        isActive = false
    }
}




extension UIColor {
    
    
    
    public convenience init(red: CGFloat, green: CGFloat, blue: CGFloat){
        
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
        
    }
    
    
    public static var random: UIColor{
        
        let random1 = CGFloat(arc4random_uniform(255))
        let random2 = CGFloat(arc4random_uniform(255))
        let random3 = CGFloat(arc4random_uniform(255))
        
        return UIColor(red: random1, green: random2, blue: random3)
        
        
    }
    
    
    
    
    
    
    
}











extension IndexPath{
    
    public func isLastInSection(for tableView: UITableView) -> Bool{
        return self == IndexPath(row: tableView.numberOfRows(inSection: section) - 1, section: section)
    }
    
    public func isFirstInSection() -> Bool{
        return self.row == 0
    }
    
}







extension CGSize {
    
    public init(width: CGFloat){
        self.init()
        self.width = width
    }
    
    public init(height: CGFloat){
        self.init()
        self.height = height
    }
    
}





extension UIEdgeInsets{
    
    public init(allInsets: CGFloat){
        self.init(top: allInsets, left: allInsets, bottom: allInsets, right: allInsets)
    }
    
    public init(hkTop: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0){
        
        self.init()
        self.top = hkTop
        self.left = left
        self.bottom = bottom
        self.right = right
        
    }
    
    
}



extension UIImage{
    public var templateImage: UIImage{
        return self.withRenderingMode(.alwaysTemplate)
    }
}



//MARK: - CONVERT DEGREES TO RADIANS
extension BinaryInteger {
    public var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}

extension FloatingPoint {
    public var degreesToRadians: Self { return self * .pi / 180 }
    public var radiansToDegrees: Self { return self * 180 / .pi }
}




// MARK: - BOOL TOGGLE FUNCTION
extension Bool{
    /// Changes value of the receiver to the opposite of what it currently is.
    public mutating func toggle(){
        self = !self
    }
    
    
}




// MARK: - UIVIEW CONVENIENCES VARS

extension CGRect{
    
    
    public init(center: CGPoint, width: CGFloat, height: CGFloat){
        self.init(x: center.x - width.half, y: center.y - height.half, width: width, height: height)
    }
    
    
    public var centerInFrame: CGPoint{
        
        return CGPoint(x: minX + (width / 2),
                       y: minY + (height / 2))
        
    }
    
    public var centerInBounds: CGPoint{
        
        return CGPoint(x: width / 2,
                       y: height / 2)
        
    }
    
    public var rightSide: CGFloat {
        get { return self.maxX }
        set { self.origin.x = newValue - self.width }
    }
    
    public var leftSide: CGFloat {
        get { return self.minX }
        set { self.origin.x = newValue }
    }
    
    public var topSide: CGFloat {
        get { return self.minY }
        set { self.origin.y = newValue }
    }
    
    public var bottomSide: CGFloat {
        get { return self.maxY }
        set { self.origin.y = newValue - self.height }
    }
    
    
    
}






extension UIView{
    
    open var rightSide: CGFloat {
        get { return frame.rightSide }
        set { frame.rightSide = newValue }
    }
    
    open var leftSide: CGFloat {
        get { return frame.leftSide }
        set { frame.leftSide = newValue }
    }
    
    open var topSide: CGFloat {
        get { return frame.topSide }
        set { frame.topSide = newValue }
    }
    
    open var bottomSide: CGFloat {
        get { return frame.bottomSide }
        set { frame.bottomSide = newValue }
    }
    
    open func stopAnimations(){
        self.subviews.forEach{$0.stopAnimations()}
        self.layer.removeAllAnimations()
        
    }
    
    
    
    open func applyShadow(width: CGFloat){
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = width
        self.layer.shadowOffset  = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1
        
    }
    
    /// Positions the view such the specified position in the receiver's bounds is aligned with the provided point in the frame of its superview.
    open func move(pointInBounds: CGPoint, toPointInSuperViewsFrame newPoint: CGPoint){
        guard let superview = superview else {return}
        let convertedPointInBounds = superview.convert(pointInBounds, from: self)
        let convertedOrigin = superview.convert(bounds.origin, from: self)
        
        let difference = convertedOrigin.getTranslation(from: convertedPointInBounds)
        let newPosition = newPoint.translated(by: difference)
        self.frame.origin = newPosition
        
    }
    
    
    open var centerInFrame: CGPoint{
        
        return center
    }
    
    open var centerInBounds: CGPoint{
        return CGPoint(x: bounds.width.half,
                       y: bounds.height.half)
    }
    
    open var halfOfWidth: CGFloat{
        return bounds.width / 2
    }
    
    open var halfOfHeight: CGFloat{
        return bounds.height / 2
    }
    
}




// MARK: - SHUFFLING

extension MutableCollection {
    /// Shuffles the contents of this collection.
    public mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}




extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    
    public func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}















//MARK: - REMOVE WHITE SPACES


extension String{
    
    public func removeWhiteSpaces() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    
    
}









extension Character{
    public var isNumber: Bool{
        return CharacterSet(charactersIn: String(self)).isSubset(of: CharacterSet.decimalDigits)
    }
    
    public var isLetter: Bool{
        return CharacterSet(charactersIn: String(self)).isSubset(of: CharacterSet.letters)
    }
}







extension Array {
    
    public var lastItemIndex: Int?{
        if isEmpty{return nil}
        return self.count - 1
    }
}






























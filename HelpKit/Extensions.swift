//
//  Extensions.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/17/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit






//public class HKValueBox<ValueType>{
//    
//    public var value: ValueType{
//        didSet{ actions.forEach{$0(value)} }
//    }
//    
//    public init(_ value: ValueType){ self.value = value }
//    
//    private var actions = [(ValueType) -> Void]()
//    private var senders = [AnyObject]()
//    
//    func addListener(sender: AnyObject, _ action: @escaping (ValueType) -> Void ){
//        actions.append(action)
//        senders.append(sender)
//    }
//    
//    func removeListender(sender: AnyObject){
//        let x = 0
//        for i in senders{
//            if i === sender{
//                
//            }
//            x += 1
//        }
//    }
//    
//}







public func handleErrorWithPrintStatement(action: () throws -> Void){
    do{ try action() } catch { print(error) }
}

public enum HKCompletionResult<ResultType>{
    case success(ResultType)
    case failure(Error)
}

public enum HKFailableCompletion{
    case success
    case failure(Error)
}


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
    
    open func cancelCurrentTouch(){
        isEnabled = false
        isEnabled = true
    }
}

public struct HKError: LocalizedError{
    public static var unknownError = HKError(description: "An unknown error occured.")

    public var errorDescription: String?
    public init(description: String){
        self.errorDescription = description
    }
}





extension UIScrollView{
    open func scrollToTop(with animationBlock: ((() -> Void) -> Void)? = nil) -> Void {
        let action = {
            
            let offset = CGPoint(x: 0, y: -self.adjustedContentInset.top)
            self.setContentOffset(offset, animated: false)
            self.layoutIfNeeded()
        }
        if let block = animationBlock{
            block(action)
        } else {action()}
        
    }
}




extension CGPoint{
    static public prefix func -(val: CGPoint) -> CGPoint{
        return CGPoint(x: -val.x, y: -val.y)
    }
    static public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint{
        return lhs.offset(by: rhs)
    }
    static public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint{
        return lhs.offset(by: -rhs)
    }
    

    public func getOffset(from point: CGPoint) -> CGPoint{
        return self - point
    }

    public func offset(by anotherPoint: CGPoint) -> CGPoint{
        var newPoint = CGPoint.zero
        newPoint.x = x + anotherPoint.x
        newPoint.y = y + anotherPoint.y
        return newPoint
    }
}



extension UIWindow{
    
   
    
    open func dismissAllPresentedViewControllers(){
        if let root = rootViewController{
            root.dismissAllPresentedViewControllers()
        }
    }
}



public var statusBar: UIWindow{
    return UIApplication.shared.value(forKey: "statusBarWindow") as! UIWindow
}
    
    
    





extension FloatingPoint{
    public var half: Self{
        return self / 2
    }
}

extension Numeric{
    public var doubled: Self{
        return self * 2
    }
    
    public var tripled: Self{
        return self * 3
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
        func getRandomNum() -> CGFloat{return CGFloat((0...255).randomElement()!)}
        let random1 = getRandomNum()
        let random2 = getRandomNum()
        let random3 = getRandomNum()
        return UIColor(red: random1, green: random2, blue: random3)
    }
    
    public static func gray(percentage: CGFloat) -> UIColor{
        return UIColor(red: percentage, green: percentage, blue: percentage, alpha: 1)
    }
}











extension IndexPath{
    
    
    public func isLastInSection(for collectionView: UICollectionView) -> Bool{
        return self == IndexPath(row: collectionView.numberOfItems(inSection: section) - 1, section: section)
    }

    
    
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
    
    public init(hktop: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0){
        
        self.init()
        self.top = hktop
        self.left = left
        self.bottom = bottom
        self.right = right
        
    }
    
    
}

extension UIImageView{
    
    public convenience init(image: UIImage? = nil, contentMode: UIView.ContentMode){
        self.init(image: image)
        self.contentMode = contentMode
    }
    
}



extension UIImage{
    public var templateImage: UIImage{
        return self.withRenderingMode(.alwaysTemplate)
    }
    
    public enum RotationConfig{
        case clockwise90
        case counterClockwise90
        case _180
        
        fileprivate var orientation: UIImage.Orientation{
            switch self{
            case .clockwise90: return .right
            case .counterClockwise90: return .left
            case ._180: return .down
            }
        }
    }
    
    public func rotatedBy(_ rotation: RotationConfig) -> UIImage?{
        if let cgImage = self.cgImage{
            return UIImage(cgImage: cgImage, scale: 1, orientation: rotation.orientation)
        } else {return nil}
        
    }
    
    
    
    
    
}







extension Bool{
    /// Changes value of the receiver to the opposite of what it currently is.
    public mutating func toggle(){
        self = !self
    }
    
    public var isFalse: Bool{
        return !self
    }
    
    public var isTrue: Bool{
        return self
    }
    
    
}




// MARK: - UIVIEW CONVENIENCES VARS

extension CGRect{
    
    
    public init(center: CGPoint, width: CGFloat, height: CGFloat){
        self.init(x: center.x - width.half, y: center.y - height.half, width: width, height: height)
    }
    
    
    public var centerAsFrame: CGPoint{
        return CGPoint(x: minX + (width / 2),
                       y: minY + (height / 2))
    }
    
    public var centerAsBounds: CGPoint{
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
    
    open func setCornerRadius(to newValue: CGFloat){
        layer.cornerRadius = newValue
        if !layer.masksToBounds{layer.masksToBounds = true}
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
        
        let difference = convertedPointInBounds - convertedOrigin
        let newPosition = newPoint - difference
        self.frame.origin = newPosition
        
    }
    
    
//    private func getViewController(of view: UIView) -> UIViewController?{
//        if let next = next{
//            if let next = next as? UIViewController{ return next }
//            else { return getViewController(of: next as! UIView) }
//        } else {return nil}
//    }
//    
//    /// Returns the view controller whose view the recever either is or is a subview of.
//    open var viewController: UIViewController?{
//        return getViewController(of: self)
//    }
    
    
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




extension UIViewController{
    
    open func present(_ vc: UIViewController){
        self.present(vc, animated: true)
    }
    
    open func dismiss(){
        dismiss(animated: true)
    }
    
    private func getTopMostLevelParent(for vc: UIViewController) -> UIViewController{
        if vc.parent.isNil { return vc }
        else {return getTopMostLevelParent(for: vc.parent!)}
    }
    /// Returns the highest parent in the viewController heirarchy
    open var topMostLevelParent: UIViewController{
        return getTopMostLevelParent(for: self)
    }
    
    
    
    public func dismissAllPresentedViewControllers(){
        if self.presentedViewController.isNil{
            return
        } else if let presented = self.presentedViewController, presented.presentedViewController.isNil{
            presented.dismiss(animated: false, completion: {
                if let presenting = self.presentingViewController{
                    presenting.dismissAllPresentedViewControllers()
                }
            })
        } else { self.presentedViewController!.dismissAllPresentedViewControllers() }
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
    
    public var isValidEmail: Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    public func withTrimmedWhiteSpaces() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    public var asURL: URL?{
        return URL(string: self)
    }
    
    public mutating func capitalizeFirstLetter(){
        self = prefix(1).uppercased() + self.dropFirst()
    }
    
    public func capitalizingFirstLetter() -> String{
        var string = self
        string.capitalizeFirstLetter()
        return string
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

extension UILabel{
    public convenience init(text: String? = nil, font: UIFont? = nil){
        self.init()
        self.text = text
        self.font = font
    }
}





public protocol HKOptionalProtocol{
    associatedtype Wrapped
    var unsafelyUnwrapped: Wrapped {get}
    var isNil: Bool{get}
}

extension Optional: HKOptionalProtocol{
    public var isNotNil: Bool{
        return self != nil
    }
    public var isNil: Bool{
        return self == nil
    }
}

extension Sequence where Element: HKOptionalProtocol{
    public func filterOutNils() -> [Element.Wrapped]{
        return self.filter({$0.isNil.isFalse}).map{$0.unsafelyUnwrapped}
    }
}



extension Array {
    public var lastItemIndex: Int?{
        if isEmpty{return nil}
        return self.count - 1
    }
}

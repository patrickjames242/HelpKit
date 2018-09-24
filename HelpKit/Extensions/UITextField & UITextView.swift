//
//  UITextField & UITextView.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/9/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

public protocol HKHasEditableText: class{
    var editableText: String? { get set}
    static var textDidChangeNotification: NSNotification.Name {get}
}

extension HKHasEditableText{
    
    /// Sets the text and sends the appropriate notification
    public func setTextTo(newText: String){
        editableText = newText
        NotificationCenter.default.post(name: Self.textDidChangeNotification, object: self)
    }
    
    public func addTextDidChangeListener(_ action: @escaping (String?) -> Void){
        NotificationCenter.default.addObserver(forName: Self.textDidChangeNotification, object: self, queue: nil, using: {[weak self]_ in action(self?.editableText)})
    }
    
    /// Returns false if the receiver's text is nil or is only white spaces
    public var hasValidText: Bool{
        if let text = editableText{
            if text.withTrimmedWhiteSpaces().isEmpty{return false}
            else {return true}
        } else {return false}
    }
}

extension UITextView: HKHasEditableText{
    public var editableText: String?{
        get{return text}
        set{text = newValue}
    }
}
extension UITextField: HKHasEditableText{
    public var editableText: String?{
        get{return text}
        set{text = newValue}
    }
}

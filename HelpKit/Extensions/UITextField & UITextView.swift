//
//  UITextField & UITextView.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/9/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

public protocol HKHasEditableText{
    var editableText: String? { get }
}

extension HKHasEditableText{
    /// Returns false if the receiver's text is nil or is only white spaces
    public var hasValidText: Bool{
        if let text = editableText{
            if text.withTrimmedWhiteSpaces().isEmpty{return false}
            else {return true}
        } else {return false}
    }
}

extension UITextView: HKHasEditableText{
    public var editableText: String?{return text}
}
extension UITextField: HKHasEditableText{
    public var editableText: String?{return text}
}

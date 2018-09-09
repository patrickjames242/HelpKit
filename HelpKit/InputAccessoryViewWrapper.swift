//
//  InputAccessoryViewWrapper.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/21/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit


/// This wrapper class only requires that the wrapped view keep it's intrinsicContentSize's height up to date.

open class InputAccessoryViewWrapper: HKView{
    
    private let wrappedView: UIView

    open private(set) var backgroundView = UIView()
    
    private var _intrinsicContentSize: CGSize

    open override var intrinsicContentSize: CGSize{
        get { return _intrinsicContentSize }
        set { _intrinsicContentSize = newValue }
    }
    
    
    
    
    open func setBackgroundView(to view: UIView){
        NSLayoutConstraint.deactivate(backgroundView.constraints)
        backgroundView.removeFromSuperview()
        backgroundView = view
        backgroundView.pinAllSides(addTo: self, pinTo: self)
        sendSubviewToBack(backgroundView)
    }
    
    
    
  
    public init(for view: UIView, width: CGFloat){
        wrappedView = view
        _intrinsicContentSize = CGSize(width: width, height: 50)

        super.init(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        autoresizingMask = .flexibleHeight
        backgroundColor = .clear
        view.pin(addTo: self, anchors: [.width: widthAnchor, .bottom: safeAreaLayoutGuide.bottomAnchor])
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        setBackgroundView(to: backgroundView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        refreshHeight()
    }
    
    open override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
        refreshHeight()
    }
    
    
    private func refreshHeight(){
        frame.size.height = safeAreaInsets.bottom + wrappedView.intrinsicContentSize.height
        intrinsicContentSize = self.frame.size
        invalidateIntrinsicContentSize()
    }
    
 
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
}


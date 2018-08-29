//  
//  HKNotifications.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/27/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension HKNotification where ActionParameterType == Void{
    open func post(){post(with: ())}
    
}

/* This class allows API users to register to be notified of events with callbacks that have TYPE  SAFE parameters, a feature Foundation's NotificationCenter cannot boast 😎.
 
    Still not convinced of it's usefulness?
 
    Well imagine you have a HUGE app with several notifications and several persons listening for those notifications, expecting certain types of information. At some point, your probably gonna forget to send the appropriate userInfo objects when you post the notification or something... and god help you if your listeners are doing some force unwrapping. Your app will go bye bye.
 
    Well, no need to worry!!! HKNotification has type safety for days!!! The compiler won't allow you to post a notification without the expected user information along with it.
*/


open class HKNotification<ActionParameterType>: WeakWrapperDelegate{
    
    public init(){}
    
    public func wrapperValueWasSetToNil(wrapper: WeakWrapperProtocol) {
        var x = 0
        for sender in senderArray{
            if sender === wrapper.unTypedSelf{
                senderArray.remove(at: x)
                let _ = actionsArray.remove(at: x)
                x -= 1
            }
            x += 1
        }
    }
    
    private var senderArray = [WeakWrapper<AnyObject>]()
    
    private var actionsArray = [(ActionParameterType) -> Void]()
    
    open func post(with parameter: ActionParameterType){
        let action = {self.actionsArray.forEach{$0(parameter)}}
        if Thread.isMainThread.isFalse{
            DispatchQueue.main.sync(execute: action)
        } else { action() }
        
    
    }
    
    open func listen(sender: AnyObject, action: @escaping (ActionParameterType) -> Void){
        senderArray.append(WeakWrapper(sender))
        actionsArray.append(action)
    }
    
    open func removeListener(sender: AnyObject){
        var x = 0
        for object in senderArray{
            if sender === object.value{
                let _ = actionsArray.remove(at: x)
                senderArray.remove(at: x)
                x -= 1
            }
            x += 1
        }
    }
}


//  
//  HKNotifications.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/27/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

class HKNotification<ActionParameterType>: WeakWrapperDelegate{
    
    
    func wrapperValueWasSetToNil(wrapper: WeakWrapperProtocol) {
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
    
    func post(with parameter: ActionParameterType){
        actionsArray.forEach{$0(parameter)}
    }
    
    func listen(sender: AnyObject, action: @escaping (ActionParameterType) -> Void){
        senderArray.append(WeakWrapper(sender))
        actionsArray.append(action)
    }
    
    func removeListener(sender: AnyObject){
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


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




public struct HKError: LocalizedError{
    public static var unknownError = HKError(description: "An unknown error occured.")

    public var errorDescription: String?
    public init(description: String){
        self.errorDescription = description
    }
}


public var statusBar: UIWindow{
    return UIApplication.shared.value(forKey: "statusBarWindow") as! UIWindow
}
    


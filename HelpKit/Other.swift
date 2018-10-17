//
//  Extensions.swift
//  HelpKit
//
//  Created by Patrick Hanna on 7/17/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit





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
    


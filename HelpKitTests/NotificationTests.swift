//
//  NotificationTests.swift
//  HelpKitTests
//
//  Created by Patrick Hanna on 8/26/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import XCTest
@testable import HelpKit



class NotificationTests: XCTestCase{
    private let passedString = "passed"
    private let failedString = "failed"

    func testNotificationActionIsCarriedOut(){
        
        let notification = HKNotification<Void>()
        var stringToTest = failedString
        notification.listen(sender: self, action: {stringToTest = self.passedString})
        notification.post()
        XCTAssertEqual(passedString, stringToTest)
    }
    
    func testNotificationInfoIsSent(){
        let notification = HKNotification<String>()
        var stringToTest = failedString
        notification.listen(sender: self) { stringToTest = $0 }
        notification.post(with: passedString)
        XCTAssertEqual(stringToTest, passedString)
    }
    
    func testRemovesListeners(){
        
        var stringToTest = passedString
        let notification = HKNotification<Void>()
        notification.listen(sender: self, action: {stringToTest = self.failedString})
        notification.removeListener(sender: self)
        notification.post()
        XCTAssertEqual(passedString, stringToTest)
    }
    
    func testAllowsDeallocationUponListenerRemoval(){
        let notification = HKNotification<Void>()
        class TestClass{}
        var strongReference: TestClass? = TestClass()
        weak var weakReference = strongReference
        
        notification.listen(sender: strongReference!, action: {})
        notification.removeListener(sender: strongReference!)
        
        strongReference = nil
        
        XCTAssertNil(weakReference)
    }
    
    
}

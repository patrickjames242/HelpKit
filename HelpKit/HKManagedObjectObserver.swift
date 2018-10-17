//
//  HKManagedObjectObserver.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/19/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import CoreData
import UIKit

final public class HKManagedObjectObserver: NSObject{
    
    public enum ChangeType{ case update, delete }
    
    
    public init?(object: NSManagedObject, changeHandler: @escaping (_ changeInfo: ChangeType?) -> Void) {
        guard let context = object.managedObjectContext else {return nil}
        super.init()
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextObjectsDidChange, object: context, queue: nil, using: {[weak self, weak object] (notification) in
            guard let self = self, let object = object else{return}
            let change = self.getChangeTypeUsing(notification: notification, object: object)
            changeHandler(change)
        })
    }
    
    public func stopObserving() {
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    private func getChangeTypeUsing(notification: Notification, object: NSManagedObject) -> ChangeType?{
        let updated = objects(in: notification, forKey: NSUpdatedObjectsKey)
        let deleted = objects(in: notification, forKey: NSDeletedObjectsKey)
        let invalidated = objects(in: notification, forKey: NSInvalidatedObjectsKey)
        let refreshed = objects(in: notification, forKey: NSRefreshedObjectsKey)
        
        let removedObjects = invalidated.union(deleted)
        let updatedObjects = updated.union(refreshed)
        
        if (notification.userInfo?[NSInvalidatedAllObjectsKey]).isNotNil || removedObjects.contains(object){return .delete}
        if updatedObjects.contains(object){return .update}
        return nil
    }
    
    
    
    private func objects(in notification: Notification, forKey key: String) -> Set<NSManagedObject>{
        return notification.userInfo?[key] as? Set<NSManagedObject> ?? []
    }
    
}


extension NSManagedObject{
    
    
    
    public func observe(usingObjectChangeHandler handler: @escaping (HKManagedObjectObserver.ChangeType?) -> Void) -> HKManagedObjectObserver?{
        return HKManagedObjectObserver(object: self, changeHandler: handler)
    }
    
    
}


//
//  NSPersistentContainer.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/13/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import CoreData


extension NSPersistentContainer{
    
    
    
    
    open func newBackgroundContext(thatSyncsWith otherContext: NSManagedObjectContext) -> NSManagedObjectContext{
        let newContext = newBackgroundContext()
        
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextDidSave, object: newContext, queue: nil) {[weak otherContext] (note) in
            
            otherContext?.perform {
                otherContext?.mergeChanges(fromContextDidSave:note)
            }
        }
        
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextDidSave, object: otherContext, queue: nil) { [weak newContext] (note) in
            
            newContext?.perform {
                newContext?.mergeChanges(fromContextDidSave: note) }
            }
        return newContext
    }
    
    
}

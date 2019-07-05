//
//  CoreDataManager.swift
//  NotesiOSApp
//
//  Created by George Shafik on 5/7/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    // this is the singleton pattern
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "NotesIOSApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        })
        return container
    }()
}

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
    
    // 1. createNoteFolder
    func createNoteFolder(title: String) -> NoteFolder {
        let context = persistentContainer.viewContext
        
        let newNoteFolder = NSEntityDescription.insertNewObject(forEntityName: "NoteFolder", into: context)
        
        newNoteFolder.setValue(title, forKey: "title")
        
        do {
            try context.save()
            return newNoteFolder as! NoteFolder
        } catch let err {
            print("Failed to save new note folder:",err)
            return newNoteFolder as! NoteFolder
        }
    }
    
    // 2. fetchNoteFolder - will return an array of NoteFolders
    func fetchNoteFolders() -> [NoteFolder] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NoteFolder>(entityName: "NoteFolder")
        
        do {
            let noteFolders = try context.fetch(fetchRequest)
            
            return noteFolders
        } catch let err {
            print("Failed to fetch note folders")
            return []
        }
    }
}

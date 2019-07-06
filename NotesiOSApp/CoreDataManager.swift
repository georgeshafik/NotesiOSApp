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
            print("Failed to fetch note folders \(err.localizedDescription)")
            return []
        }
    }
    
    func deleteNoteFolder(noteFolderRelationShip: NoteFolder) -> Bool {
        let context = persistentContainer.viewContext
        
        context.delete(noteFolderRelationShip);
        
        do {
            try context.save() // this save performs the delete oepration on core data
            return true
        } catch let err {
            print("error deleting nnote folder entity instance", err)
            return false
        }
    }
    
    // NOTE FUNCTIONS
    func createNewNote(title: String, date: Date, text: String, noteFolder: NoteFolder) -> Note {
        let context = persistentContainer.viewContext
       
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note

        newNote.setValue(title, forKey: "title")
        newNote.text = text
        newNote.date = date
        newNote.noteFolderRelationShip = noteFolder
        
        do {
            try context.save()
            return newNote
        } catch let err {
            print("Failed to save new note folder:",err)
            return newNote
        }
    }
    
    func fetdhNotes(fromr noteFolder: NoteFolder) -> [Note] {
        guard let folderNotes = noteFolder.notes?.allObjects as? [Note] else { return [] }
        return folderNotes
    }
    
    func deleteNote(note: Note) -> Bool {
        let context = persistentContainer.viewContext
        
        context.delete(note);
        
        do {
            try context.save() // this save performs the delete oepration on core data
            return true
        } catch let err {
            print("error deleting note entity instance", err)
            return false
        }
    }
    
    func saveUpdatedNote(note: Note, newText: String) {
        let context = persistentContainer.viewContext
        
        note.title = newText
        note.text = newText
        note.date = Date()
        
        do {
            try context.save()
        } catch let err {
            print("error saving/updating note", err)
        }
    }
}

//
//  FolderNotesController.swift
//  NotesiOSApp
//
//  Created by George Shafik on 30/6/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit

class FolderNotesController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil) // we are setting to nil because we want to use it on our table view
    
    
    var folderData:NoteFolder! {
        didSet {
//            self.notes = folderData.notes // this will be replace with a relationship in core data model between the entities NoteFolder and the Notes arrays
            filteredNotes = notes
        }
    }

    fileprivate var notes = [Note]() // array of notes
    fileprivate var filteredNotes = [Note]() // need a copy of notes to restor list when there is an empty search string
    
    fileprivate let CELL_ID:String = "CELL_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Folder Notes"
        
        setupTableView()
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        self.definesPresentationContext = true  // this allows the keyboard to popup when our using runs this on a real device
                                                // also bottom navigation bar remains white
        
        navigationItem.searchController = searchController // hooked up our searchController into the top nagivation bar
        navigationItem.hidesSearchBarWhenScrolling = false  // hide search bar when scroller - good when you have a lot of items to read
        searchController.dimsBackgroundDuringPresentation = true // dims background when typing in serach terms into search controller
        searchController.searchBar.delegate = self
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let items: [UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "5 Notes", style: .done, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(self.createNewNote))
        ]
        
        self.toolbarItems = items
    }
    
    @objc fileprivate func createNewNote() {
        let noteDetailedController = NoteDetailController()
        navigationController?.pushViewController(noteDetailedController, animated: true)
    }
    
    fileprivate func setupTableView() {
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        // hooking in NoteCell
        tableView.register(NoteCell.self, forCellReuseIdentifier: CELL_ID)
    }
    
    var cachedText:String = ""

}


// This ensures we have defined the delegate to our serach bar
// We can simply reference self as we exetend FolderNotesController
extension FolderNotesController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNotes = notes.filter( { (note) -> Bool in
            // also make seach case insensitive
            return note.title?.lowercased().contains(searchText.lowercased()) ?? false // if title does not exist then applying lowercased ... etc will not work either so simply fail it by placing ?? and returning a false failing it
        })
        if searchBar.text!.isEmpty && filteredNotes.isEmpty {
            filteredNotes = notes
        }
        cachedText = searchText
        tableView.reloadData()
    }
    
    // Tells the UISearchBarDelegeate with have ended entering text in the Search Bar
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !cachedText.isEmpty && !filteredNotes.isEmpty {
            searchController.searchBar.text = cachedText
        }
    }
}

extension FolderNotesController {
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var actions = [UITableViewRowAction]()
        
        // we need to provide actions
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delecte") {(action, indexPath) in
            print("tyring to delete item at indexPath", indexPath)
            let targetRow = indexPath.row
            self.notes.remove(at: targetRow)
            self.filteredNotes.remove(at: targetRow)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        actions.append(deleteAction)
        
        return actions;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        // hooking in NoteCell
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! NoteCell
        //cell.textLabel?.text = "here's a note"
        let noteForRow = self.filteredNotes[indexPath.row] // using self data is in same class
        cell.noteData = noteForRow
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // we will push a notes view controller here!
        let noteDetailController = NoteDetailController()
        navigationController?.pushViewController(noteDetailController, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


//
//  FolderNotesController.swift
//  NotesiOSApp
//
//  Created by George Shafik on 30/6/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit

class FolderNotesController: UITableViewController {
    var folderData:NoteFolder! {
        didSet {
            self.notes = folderData.notes
        }
    }

    fileprivate var notes = [Note]() // array of notes
    
    fileprivate let CELL_ID:String = "CELL_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Folder Notes"
        
        setupTableView()
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
}

extension FolderNotesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        // hooking in NoteCell
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! NoteCell
        //cell.textLabel?.text = "here's a note"
        let noteForRow = self.notes[indexPath.row] // using self data is in same class
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


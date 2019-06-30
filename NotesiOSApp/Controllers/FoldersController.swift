//
//  ViewController.swift
//  NotesiOSApp
//
//  Created by George Shafik on 30/6/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit

extension FoldersController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        cell.textLabel?.text = "here's a note folder"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderNotesController = FolderNotesController()
        
        // push it onto the stack
        navigationController?.pushViewController(folderNotesController, animated: true)
    }
}

// UITableViewController contains UITableViewSource and UITableViewDelegate
class FoldersController: UITableViewController {

    // Reason we are using CELL_ID as a constant so we can register it in our table view a
    fileprivate let CELL_ID:String = "CELL_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Folders"
        
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
    }


}


//
//  ViewController.swift
//  NotesiOSApp
//
//  Created by George Shafik on 30/6/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit


// UITableViewController contains UITableViewSource and UITableViewDelegate
class FoldersController: UITableViewController {

    // Reason we are using CELL_ID as a constant so we can register it in our table view a
    fileprivate let CELL_ID:String = "CELL_ID"
    
    // We are using a UIView so we can place a label inside it with some spacing round it
    fileprivate let headerView:UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        let label = UILabel(frame: CGRect(x: 20, y: 15, width: 100, height: 20))
        label.text = "ICLOUD"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .darkGray
        headerView.addBorder(toSide: .bottom, withColor: UIColor.lightGray.withAlphaComponent(0.5).cgColor, andThickness: 0.3)
        headerView.addSubview(label)
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Folders"
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigation Controller has a toolbar that we can show when we show this controller
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Navigation Controller has a toolbar that we can hid we we leave this controller
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.tableHeaderView = headerView
    }

}

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





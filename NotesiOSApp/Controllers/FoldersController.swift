//
//  ViewController.swift
//  NotesiOSApp
//
//  Created by George Shafik on 30/6/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit

//// Best way to create data is to place it outside the classes.
//// Later we will remove this code when we get to the Core Data.
//// Basically we are going to migrate this code to Core Data when we get to that.
//let firstFolderNotes = [
//    Note(title: "UITableViews", date: Date(), text: "table views use protocols to receive data"),
//    Note(title: "Collection Views", date: Date(), text: "collection views can be customized with flow layouts to create layouts like you see in the Pinterest app.."),
//    Note(title: "Flow Views", date: Date(), text: "custom= layouts can be make with UICollectionViewFlowLayout")
//]
//
//let secondFolderNotes = [
//    Note(title: "Instagram", date: Date(), text: "I have tow Instragram accounts. maxcodes && maxcodes.io"),
//    Note(title: "YouTube Channels", date: Date(), text: "I also have two youtube channels. One for iOS development videos, another for developer vlogs.")
//]
//
//var noteFolders:[NoteFolder] = [
//    NoteFolder(title: "Course Notes", notes: firstFolderNotes),
//    NoteFolder(title: "Social Media", notes: secondFolderNotes)
//]

// temp fix while we refactor code to make use of Core Data 
var noteFolders = [NoteFolder]()

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
        
        //view.backgroundColor = UIColor.init(rgb: 0x00FFFF)
        navigationItem.title = "Folders"
        
        noteFolders = CoreDataManager.shared.fetchNoteFolders()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigation Controller has a toolbar that we can show when we show this controller
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        // We placed a flexible barButtonSystemItem to pushed our New Folder toolbar button to the right
        let items:[UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "New Folder", style: .done, target: self, action: #selector(self.handleAddNewFolder))
        ]
        
        self.toolbarItems = items
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
        //self.navigationController?.setToolbarItems([editButton], animated: false)
        //self.navigationItem.rightBarButtonItem = editButton
        self.navigationItem.setRightBarButton(editButton, animated: false)
        
        self.navigationController?.toolbar.tintColor = .primaryColor // bottom toolbar
        self.navigationController?.navigationBar.tintColor = .primaryColor // top toolbar
        
        setupTranslucentView()
        
        self.tableView.reloadData()
    }
    
    
    var textField:UITextField!
    
    @objc fileprivate func handleAddNewFolder() {
        let addAlert = UIAlertController(title: "New Folder", message: "Enter a name for this folder.", preferredStyle: .alert)
        
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            addAlert.dismiss(animated: true)
        }))
        
        addAlert.addTextField { (tf) in
            // reference textfield outside of this method
            self.textField = tf
        }
        
        addAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in addAlert.dismiss(animated: true)
           addAlert.dismiss(animated: true)
            
            // insert a new folder with the correct title
            guard let title = self.textField.text else { return }
            
            let newFolder = CoreDataManager.shared.createNoteFolder(title: title)
            noteFolders.append(newFolder)
            self.tableView.insertRows(at: [IndexPath(row: noteFolders.count-1, section: 0)], with: .fade)
        }))
        
        present(addAlert, animated: true)
    }
    
// Comment this out because we do not want to hide Toolbar on other view controllers
// We basically want our Toolbar to remain visiable on other view controllers
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        // Navigation Controller has a toolbar that we can hid we we leave this controller
//        self.navigationController?.setToolbarHidden(true, animated: false)
//    }
    
    // We need to create a different type of UITableViewCell
    fileprivate func setupTableView() {
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        // Note registered UITableViewCell but FolderCell
        tableView.register(FolderCell.self, forCellReuseIdentifier: CELL_ID)

        tableView.tableHeaderView = headerView
    }
    
    fileprivate func getImage(withColor color: UIColor, andSize size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
    
    fileprivate func setupTranslucentView() {
        // we have access to bottom toolbar
        let toolBar = self.navigationController?.toolbar
        
        // we have access to top navigation bar
        let navigationBar = self.navigationController?.navigationBar

        let slightWhite = getImage(withColor: UIColor.white.withAlphaComponent(0.9), andSize: CGSize(width: 30, height: 30))
        toolBar?.setBackgroundImage(slightWhite, forToolbarPosition: .any, barMetrics: .default)
        
        // This will get ride of the line in the bottom toolbar
        toolBar?.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        // Remove line in top navigatin bar also
        navigationBar?.setBackgroundImage(slightWhite, for: .default)
        navigationBar?.shadowImage  = slightWhite
    }
}

extension FoldersController {
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            let myNoteFolder = noteFolders[indexPath.row]
            if CoreDataManager.shared.deleteNoteFolder(noteFolderRelationShip: myNoteFolder) {
                noteFolders.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We constained the number of rows to view to the number of rows of data we have
        return noteFolders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // We need to use our FolderCell and provide it some data
        // Cast our cell as FolderCell, make sure you register it first
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! FolderCell
        
        // We have content in the customer cell and don't require this
        // This cell has default values but we are not using them
        //cell.textLabel?.text = "here's a note folder"
        //cell.accessoryType = .disclosureIndicator // places the little arrow on the right of the cell row record
        
        let folderForRow = noteFolders[indexPath.row]
        cell.folderData = folderForRow // setting cel.folderData will call cell didSet method in FolderCell.swift

// if we remove fileprivate in FolderCell.swift
// from
//        fileprivate var label: UILabel =
//        fileprivate var countLabel: UILabel =
// To this:
//        var label: UILabel =
//        var countLabel: UILabel =
// Then we can do the following
//        cell.label.text = folderForRow.title
//        cell.countLabel.text = String(folderForRow.notes.count)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderNotesController = FolderNotesController()
        let folderForRowSelected = noteFolders[indexPath.row]
        folderNotesController.folderData = folderForRowSelected
        // push it onto the stack
        navigationController?.pushViewController(folderNotesController, animated: true)
    }
}





//
//  FolderCell.swift
//  NotesiOSApp
//
//  Created by George Shafik on 1/7/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit

class FolderCell: UITableViewCell {
    
    var folderData:NoteFolder! {
        didSet {
            label.text = folderData.title
            countLabel.text = String(folderData.notes.count)
        }
    }
    
    fileprivate var label: UILabel = {
        let label = UILabel()
        label.text = "Folder title"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    fileprivate var countLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    // Create a stackview to place the labels in and then set constraint on the stackview
    // Also mark stackview lazy for the callback to label, countLabel
    // can compile label, countLabel, init first then compile run stack
    // So lazy ensure label, countLabel, init are avaiable first for stack to use.
    fileprivate lazy var stack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [label, countLabel])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        return s
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        // stack will be constraint to the view of the cell
        //        Summary Help on contentView
        //
        //        The content view of the cell object.
        //        Declaration
        //
        //        var contentView: UIView { get }
        //        Discussion
        //
        //        The content view of a UITableViewCell object is the default superview for content displayed by the cell.
        //        If you want to customize cells by simply adding additional views, you should add them to the
        //        content view so they will be positioned appropriately as the cell transitions into and out of editing mode.
        contentView.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true;
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true;
        stack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true;
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

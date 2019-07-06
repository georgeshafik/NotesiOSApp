//
//  NoteCell.swift
//  NotesiOSApp
//
//  Created by George Shafik on 1/7/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    var noteData:Note! {
        didSet {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            noteTitle.text = noteData.title
            dateLabel.text = dateFormatter.string(from: noteData.date ?? Date()) // if you note and don't have a date then you want it modified to today so creating a current date Date() is fine
            previewLabel.text = noteData.text
        }
    }
    
    // note title
    fileprivate var noteTitle: UILabel = {
        let label = UILabel()
        label.text = "Places to take photos"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    // date label
    fileprivate var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "01/07/19"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    // preview label
    fileprivate var previewLabel: UILabel = {
        let label = UILabel()
        label.text = "the note text will go here to create a preview...."
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = UIColor.gray.withAlphaComponent(0.8)
        return label
    }()
    
    // horizontal stack view
    fileprivate lazy var hoizontalStackView: UIStackView = {
        //
        let s = UIStackView(arrangedSubviews: [dateLabel, previewLabel, UIView()])  // UIView()] will give us an empty space on the right
        //s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.spacing = 10
        s.alignment = .leading
        return s
    }()
    
    // vertical stack view
    fileprivate lazy var verticalStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [noteTitle, hoizontalStackView])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = 4
        return s
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //contentView.backgroundColor = .cyan
        contentView.addSubview(verticalStackView)
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true;
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true;
//        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true;
//        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true;
        verticalStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

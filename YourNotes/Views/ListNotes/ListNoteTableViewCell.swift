//
//  ListNoteTableViewCell.swift
//  YourNotes
//
//  Created by Wojciech Spaleniak on 06/11/2022.
//

import UIKit

class ListNoteTableViewCell: UITableViewCell {

    static let identifier = String(describing: ListNoteTableViewCell.self)
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setup(note: Note) {
        titleLbl.text = note.title
        descriptionLbl.text = note.desc
    }
}

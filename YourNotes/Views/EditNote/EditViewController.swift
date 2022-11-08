//
//  EditViewController.swift
//  YourNotes
//
//  Created by Wojciech Spaleniak on 07/11/2022.
//

import UIKit

class EditViewController: UIViewController {

    static let identifier = String(describing: EditViewController.self)
    
    var note: Note?
    weak var delegate: ListNotesDelegate?
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = note?.text
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Methods to implement
    private func updateNote() {
        note?.lastUpdated = Date()
        CoreDataManager.shared.save()
        delegate?.refreshNotes()
    }
    
    private func deleteNote() {
        delegate?.deleteNote(with: note?.id ?? UUID())
        CoreDataManager.shared.deleteNote(note ?? Note())
    }
}

// MARK: UITextView Delegate
extension EditViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text
        if note?.title.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
        }
    }
}

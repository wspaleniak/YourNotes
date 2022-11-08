//
//  EditViewController.swift
//  YourNotes
//
//  Created by Wojciech Spaleniak on 07/11/2022.
//

import UIKit

class EditViewController: UIViewController {

    static let identifier = String(describing: EditViewController.self)
    
    var note: Note!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = note.text
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
    }
    
    private func deleteNote() {
        CoreDataManager.shared.deleteNote(note)
    }
}

// MARK: UITextView Delegate
extension EditViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            deleteNote()
        } else if textView.text != note.text {
            note.text = textView.text
            updateNote()
        }
    }
}

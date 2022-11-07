//
//  Note.swift
//  YourNotes
//
//  Created by Wojciech Spaleniak on 06/11/2022.
//

import Foundation

class Note {
    let id = UUID()
    var text: String = ""
    var lastUpdated: Date = Date()
    
    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""  // return first line of text
    }
    
    var description: String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return "\(lastUpdated.format()) \(lines.first ?? "")"   // return second line of text
    }
}

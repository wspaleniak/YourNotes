//
//  Note+CoreDataClass.swift
//  YourNotes
//
//  Created by Wojciech Spaleniak on 07/11/2022.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""
    }
    
    var desc: String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return "\(lastUpdated.format()) \(lines.first ?? "")"
    }
}

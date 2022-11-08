//
//  CoreDataManager.swift
//  YourNotes
//
//  Created by Wojciech Spaleniak on 07/11/2022.
//

/*
 NOTE:
 
 MANAGED OBJECT CONTEXT
 - niczym kartka papieru wyrwana z książki
 - możesz na niej szkicować, rysować, etc.
 - jednakże dane nie są przechowywane, dopóki kartka nie wróci do książki
 - czyli możesz modyfikować wartości, ale to nie wpłynie na UI, nic się nie zmieni, dopóki tego nie zapiszesz
 
 MANAGED OBJECT MODEL
 - coś jak struktura danych
 - posiada atrybuty, podmioty, powiązania
 - opisuje rodzaj danych, które chcemy przechowywać
 
 PERSISTENT STORE COORDINATOR
 - jak sama nazwa wskazuje, koordynuje
 - jest mediatorem pomiędzy kontekstem dziejącym się w aplikacji, a miejscem przechowywania danych na urządzeniu
 
 PERSISTENT STORE CONTAINER
 - daje nam atrybuty, właściwości, metody, które pomagają w komunikacji z kontekstem
 
 
 */

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "YourNotes")
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("An error ocurred while saving: \(error.localizedDescription)")
            }
        }
    }
}

extension CoreDataManager {
    
    func createNote() -> Note {
        let note = Note(context: viewContext)
        note.id = UUID()
        note.text = ""
        note.lastUpdated = Date()
        save()
        return note
    }
    
    func fetchNotes(filter: String? = nil) -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        
        return (try? viewContext.fetch(request)) ?? []
    }
    
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
}

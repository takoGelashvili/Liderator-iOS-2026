//
//  Presenter.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

import Foundation

protocol Presenter: AnyObject {
    func viewDidLoad()
    func addNote(with title: String)
    func deleteNote(at index: Int)
    func updateNote(at index: Int, with title: String)
    var notes: [Note] { get }
}

final class PresenterImpl: Presenter {
    var notes: [Note] = []
    weak let view: ViewProtocol?
    let useCase: PersistanceUseCase
    
    init(view: ViewProtocol?, useCase: PersistanceUseCase) {
        self.view = view
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        do {
            notes = try useCase.getNotes()
            view?.reload()
        } catch {
            print("ERROR GET")
        }
    }
    
    func addNote(with title: String) {
        let newNote = Note(
            id: UUID(),
            title: title
        )
        
        do {
            try useCase.addNote(newNote)
            notes.append(newNote)
            view?.reload()
        } catch {
            print("ERROR ADD")
        }
    }
    
    func deleteNote(at index: Int) {
        let note = notes[index]
        
        do {
            try useCase.deleteNote(note)
            notes.remove(at: index)
            view?.reload()
        } catch {
            print("ERROR DELETE")
        }
    }
    
    func updateNote(at index: Int, with title: String) {
        do {
            var note = notes[index]
            note.title = title
            
            try useCase.updateNote(note)
            notes[index].title = title
            view?.reload()
        } catch {
            print("ERROR UPDATE")
        }
    }
}
